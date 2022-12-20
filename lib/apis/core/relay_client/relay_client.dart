import 'dart:async';
import 'dart:convert';

import 'package:stream_channel/stream_channel.dart';
import 'package:event/src/eventargs.dart';
import 'package:event/src/event.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
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

  /// Events ///
  /// Relay Client
  @override
  Event<EventArgs> get onRelayClientConnect => Event();

  @override
  Event<EventArgs> get onRelayClientDisconnect => Event();

  @override
  Event<ErrorEvent> get onRelayClientError => Event<ErrorEvent>();

  @override
  Event<MessageEvent> get onRelayClientMessage => Event<MessageEvent>();

  /// Subscriptions
  @override
  Event<SubscriptionEvent> get onSubscriptionCreated =>
      Event<SubscriptionEvent>();

  @override
  Event<SubscriptionDeletionEvent> get onSubscriptionDeleted =>
      Event<SubscriptionDeletionEvent>();

  @override
  Event<EventArgs> get onSubscriptionResubscribed => Event();

  @override
  Event<EventArgs> get onSubscriptionSync => Event();

  bool _initialized = false;

  late String _relayUrl;
  final String _projectId;

  ICryptoUtils cryptoUtils;
  ICrypto crypto;

  late WebSocketChannel socket;
  late Peer jsonRPC;

  String get messageTrackerPrefix =>
      '${WalletConnectConstants.CORE_STORAGE_PREFIX}$VERSION//$RELAYER_CONTEXT';
  String get subscriptionPrefix =>
      '${WalletConnectConstants.CORE_STORAGE_PREFIX}$VERSION//$SUBSCRIPTIONS_CONTEXT';
  Map<String, Map<String, String>> messageRecords = {};
  Store? messageTracker;

  /// Stores all the subs that haven't been completed
  Map<String, Future<dynamic>> pendingSubscriptions = {};

  /// Stores mappings from topic -> subscription id
  Store? topicMap;

  final bool test;

  RelayClient(
    this._projectId,
    this.crypto,
    this.cryptoUtils, {
    this.test = false,
    relayUrl = RELAYER_DEFAULT_RELAY_URL,
    Store? messageTracker,
    Store? topicMap,
  }) {
    _relayUrl = relayUrl;
    if (messageTracker != null) this.messageTracker = messageTracker;
    if (topicMap != null) this.topicMap = topicMap;
  }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await crypto.init();

    // Setup the json RPC server
    jsonRPC = await _createJsonRPCProvider();
    jsonRPC.registerMethod(JSON_RPC_PUBLISH, _handlePublish);
    jsonRPC.registerMethod(JSON_RPC_SUBSCRIBE, _handleSubscribe);
    jsonRPC.registerMethod(JSON_RPC_UNSUBSCRIBE, _handleUnsubscribe);
    jsonRPC.listen();

    // Initialize all of our stores
    if (test) {
      _initialized = true;
      return;
    }
    messageTracker ??= Store(messageTrackerPrefix);
    topicMap ??= Store(subscriptionPrefix);
    Future.wait([
      messageTracker!.init(),
      topicMap!.init(),
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

    try {
      await jsonRPC.sendRequest(
        _buildMethod(JSON_RPC_PUBLISH),
        data,
      );
      await _recordMessageEvent(topic, message);
    } catch (e) {
      onRelayClientError.broadcast(ErrorEvent(e));
    }
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

    int id = int.parse(topicMap!.get(topic));

    try {
      await jsonRPC.sendRequest(
        _buildMethod(JSON_RPC_UNSUBSCRIBE),
        {
          'topic': topic,
          'id': id,
        },
      );
    } catch (e) {
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    // Temove the subscription
    pendingSubscriptions.remove(topic);
    await topicMap!.delete(topic);

    // Delete all the messages
    _deleteSubscriptionMessages(topic);
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
    if (test) {
      StreamController<String> data = StreamController.broadcast();
      return Peer(StreamChannel(data.stream, data.sink));
    }
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

  Future<bool> handlePublish(String topic, String message) async {
    // If we want to ignore the message, stop
    if (await _shouldIgnoreMessageEvent(topic, message)) return false;

    // Record a message event
    _recordMessageEvent(topic, message);

    // Broadcast the message
    onRelayClientMessage.broadcast(
      MessageEvent(
        topic,
        message,
      ),
    );
    return true;
  }

  Future<bool> _handlePublish(Parameters params) async {
    String topic = params['topic'].value;
    String message = params['message'].value;
    return await handlePublish(topic, message);
  }

  int _handleSubscribe(Parameters params) {
    return params.hashCode;
  }

  void _handleUnsubscribe(Parameters params) {}

  /// MESSAGE HANDLING

  Map<String, String> _loadMessages(String topic) {
    try {
      return jsonDecode(messageTracker!.get(topic));
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
    await messageTracker!.set(topic, jsonEncode(messageRecords[topic]));
  }

  bool _messageIsRecorded(String topic, String message) {
    final String hash = cryptoUtils.hashMessage(message);
    return messageRecords.containsKey(topic) &&
        messageRecords[topic]!.containsKey(hash);
  }

  Future<void> _deleteSubscriptionMessages(String topic) async {
    messageRecords.remove(topic);
    await messageTracker!.delete(topic);
  }

  Future<bool> _shouldIgnoreMessageEvent(String topic, String message) async {
    if (!await _isSubscribed(topic)) return true;
    return _messageIsRecorded(topic, message);
  }

  /// SUBSCRIPTION HANDLING

  Future<int> _onSubscribe(String topic) async {
    try {
      jsonRPC.sendRequest(
        _buildMethod(JSON_RPC_SUBSCRIBE),
        {
          'topic': topic,
        },
      );
    } catch (e) {
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    final int requestId = await pendingSubscriptions[topic];
    await topicMap!.set(topic, requestId.toString());
    pendingSubscriptions.remove(topic);

    return requestId;
  }

  Future<bool> _isSubscribed(String topic) async {
    if (topicMap!.has(topic)) {
      return true;
    }

    if (pendingSubscriptions.containsKey(topic)) {
      await pendingSubscriptions[topic];
      return topicMap!.has(topic);
    }

    return false;
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
