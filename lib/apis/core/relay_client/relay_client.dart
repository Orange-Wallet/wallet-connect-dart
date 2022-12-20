import 'dart:convert';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:wallet_connect_v2/apis/core/store/store.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';
import 'package:wallet_connect_v2/apis/utils/misc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RelayClient implements IRelayClient {
  static const RELAYER_DEFAULT_RELAY_URL = 'irn';
  static const PROTOCOL = 'wc';
  static const VERSION = '2';
  static const RELAYER_CONTEXT = 'relayer';
  static const SUBSCRIPTIONS_CONTEXT = 'subscriptions';

  static const JSON_RPC_PUBLISH = 'publish';
  static const JSON_RPC_SUBSCRIBE = 'subscribe';
  static const JSON_RPC_UNSUBSCRIBE = 'unsubscribe';

  bool _initialized = false;

  late String _relayUrl;
  final String _projectId;

  ICryptoUtils cryptoUtils;
  ICrypto crypto;

  late WebSocketChannel socket;
  late Peer jsonRPC;

  String get _messageTrackerPrefix =>
      '${WalletConnectConstants.CORE_STORAGE_PREFIX}$VERSION//$RELAYER_CONTEXT';
  String get _subscriptionPrefix =>
      '${WalletConnectConstants.CORE_STORAGE_PREFIX}$VERSION//$SUBSCRIPTIONS_CONTEXT';
  Map<String, Map<String, String>> messageRecords = {};
  late Store messageTracker;

  /// Stores all the subs that haven't been completed
  Map<String, Future<dynamic>> pendingSubscriptions = {};

  /// Stores mappings from topic -> subscription id
  late Store topicMap;

  /// Stores subscription id -> subscription info
  late Store subs;

  RelayClient(
    this._projectId,
    this.crypto,
    this.cryptoUtils, {
    relayUrl = RELAYER_DEFAULT_RELAY_URL,
  }) {
    _relayUrl = relayUrl;
  }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    // Setup the json RPC server
    jsonRPC = await _createJsonRPCProvider();
    jsonRPC.registerMethod(JSON_RPC_PUBLISH, _handlePublish);
    jsonRPC.registerMethod(JSON_RPC_SUBSCRIBE, _handleSubscribe);
    jsonRPC.registerMethod(JSON_RPC_UNSUBSCRIBE, _handleUnsubscribe);

    // Initialize all of our stores
    messageTracker = Store(_messageTrackerPrefix);
    topicMap = Store(_subscriptionPrefix);
    subs = Store(_subscriptionPrefix);
    Future.wait([
      messageTracker.init(),
      topicMap.init(),
      subs.init(),
    ]);

    _initialized = true;
  }

  @override
  Future<void> publish(
    String topic,
    String message,
    int ttl, {
    bool? prompt,
    int? tag,
  }) async {
    _checkInitialized();

    Map<String, dynamic> data = {
      'message': message,
      'ttl': ttl,
      'topic': topic,
    };

    if (prompt != null) data['prompt'] = prompt;
    if (tag != null) data['tag'] = tag;

    await jsonRPC.sendRequest(
      _buildMethod(JSON_RPC_PUBLISH),
      data,
    );
    await _recordMessageEvent(topic, message);
  }

  @override
  Future<int> subscribe(String topic) async {
    _checkInitialized();

    pendingSubscriptions[topic] = _onSubscribe(topic);

    return await pendingSubscriptions[topic];
  }

  @override
  Future<void> unsubscribe(String topic) async {
    _checkInitialized();

    int id = int.parse(topicMap.get(topic));

    await jsonRPC.sendRequest(
      _buildMethod(JSON_RPC_UNSUBSCRIBE),
      {
        'topic': topic,
        'id': id,
      },
    );

    // Temove the subscription
    pendingSubscriptions.remove(topic);
    await topicMap.delete(topic);

    // Delete all the messages
    messageRecords.remove(topic);
    messageTracker.delete(topic);
  }

  @override
  Future<void> connect(String? relayUrl) async {
    _checkInitialized();

    if (relayUrl != null) {
      _relayUrl = relayUrl;
    }
    jsonRPC = await _createJsonRPCProvider();
  }

  @override
  Future<void> disconnect() async {
    _checkInitialized();
    await jsonRPC.close();
  }

  /// PRIVATE FUNCTIONS ///

  Future<Peer> _createJsonRPCProvider() async {
    var auth = await crypto.signJWT(_relayUrl);
    socket = WebSocketChannel.connect(
      Uri.parse(
        MiscUtils.formatRelayRpcUrl(
          PROTOCOL,
          VERSION,
          _relayUrl,
          '1.0.0',
          auth,
          _projectId,
        ),
      ),
    );

    return Peer(socket.cast<String>());
  }

  String _buildMethod(String method) {
    return '${RELAYER_DEFAULT_RELAY_URL}_$method';
  }

  /// JSON RPC MESSAGE HANDLERS

  Future<bool> _handlePublish(Parameters params) async {
    return true;
  }

  int _handleSubscribe(Parameters params) {
    return params.hashCode;
  }

  void _handleUnsubscribe(Parameters params) {}

  /// MESSAGE HANDLING

  Map<String, String> _loadMessages(String topic) {
    try {
      return jsonDecode(messageTracker.get(topic));
    } catch (e) {
      return {};
    }
  }

  Future<void> _recordMessageEvent(String topic, String message) async {
    final String hash = cryptoUtils.hashMessage(message);
    if (!messageRecords.containsKey(topic)) {
      messageRecords[topic] = _loadMessages(topic);
    }
    messageRecords[topic]![hash] = message;
    await messageTracker.set(topic, jsonEncode(messageRecords[topic]));
  }

  Future<void> _deleteSubscriptionMessages(String topic) async {
    messageRecords.remove(topic);
    await messageTracker.delete(topic);
  }

  bool _shouldIgnoreMessageEvent(String topic, String message) {
    return false;
  }

  /// SUBSCRIPTION HANDLING

  Future<int> _onSubscribe(String topic) async {
    jsonRPC.sendRequest(
      _buildMethod(JSON_RPC_SUBSCRIBE),
      {
        'topic': topic,
      },
    );

    final int requestId = await pendingSubscriptions[topic];
    await topicMap.set(topic, requestId.toString());
    pendingSubscriptions.remove(topic);

    return requestId;
  }

  Future<bool> _isSubscribed(String topic) async {
    if (topicMap.map.containsKey(topic)) {
      return true;
    }

    if (pendingSubscriptions.containsKey(topic)) {
      await pendingSubscriptions[topic];
      return topicMap.map.containsKey(topic);
    }

    return false;
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
