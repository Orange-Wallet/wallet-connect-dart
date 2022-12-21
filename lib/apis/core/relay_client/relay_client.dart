import 'dart:async';
import 'dart:convert';

import 'package:stream_channel/stream_channel.dart';
import 'package:event/src/eventargs.dart';
import 'package:event/src/event.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/i_message_tracker.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/message_tracker.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/topic_map.dart';
import 'package:wallet_connect_v2/apis/core/store/get_storage_store.dart';
import 'package:wallet_connect_v2/apis/core/store/store.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';
import 'package:wallet_connect_v2/apis/utils/misc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'i_topic_map.dart';

class RelayClient implements IRelayClient {
  static const RELAYER_DEFAULT_RELAY_URL = 'irn';
  static const PROTOCOL = 'wc';
  static const VERSION = '2.0';

  static const JSON_RPC_PUBLISH = 'publish';
  static const JSON_RPC_SUBSCRIBE = 'subscribe';
  static const JSON_RPC_UNSUBSCRIBE = 'unsubscribe';

  /// Events ///
  /// Relay Client
  Event _onRelayClientConnect = Event();
  @override
  Event<EventArgs> get onRelayClientConnect => _onRelayClientConnect;

  Event _onRelayClientDisconnect = Event();
  @override
  Event<EventArgs> get onRelayClientDisconnect => _onRelayClientDisconnect;

  Event<ErrorEvent> _onRelayClientError = Event<ErrorEvent>();
  @override
  Event<ErrorEvent> get onRelayClientError => _onRelayClientError;

  Event<MessageEvent> _onRelayClientMessage = Event<MessageEvent>();
  @override
  Event<MessageEvent> get onRelayClientMessage => _onRelayClientMessage;

  /// Subscriptions
  Event<SubscriptionEvent> _onSubscriptionCreated = Event<SubscriptionEvent>();
  @override
  Event<SubscriptionEvent> get onSubscriptionCreated => _onSubscriptionCreated;

  Event<SubscriptionDeletionEvent> _onSubscriptionDeleted =
      Event<SubscriptionDeletionEvent>();
  @override
  Event<SubscriptionDeletionEvent> get onSubscriptionDeleted =>
      _onSubscriptionDeleted;

  Event _onSubscriptionResubscribed = Event();
  @override
  Event<EventArgs> get onSubscriptionResubscribed =>
      _onSubscriptionResubscribed;

  Event _onSubscriptionSync = Event();
  @override
  Event<EventArgs> get onSubscriptionSync => _onSubscriptionSync;

  bool _initialized = false;

  late WebSocketChannel socket;
  late Peer jsonRPC;

  /// Stores all the subs that haven't been completed
  Map<String, Future<dynamic>> pendingSubscriptions = {};

  IMessageTracker? messageTracker;
  ITopicMap? topicMap;

  ICore core;

  final bool test;

  RelayClient(
    this.core, {
    this.messageTracker,
    this.topicMap,
    this.test = false,
    relayUrl = RELAYER_DEFAULT_RELAY_URL,
  });

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
    jsonRPC.listen();

    // Initialize all of our stores
    if (test) {
      _initialized = true;
      return;
    }
    messageTracker ??= MessageTracker(core);
    topicMap ??= TopicMap(core);
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
      print('publishing');
      var value = await jsonRPC.sendRequest(
        JSON_RPC_PUBLISH,
        data,
      );
      print(value);
      await messageTracker!.recordMessageEvent(topic, message);
    } catch (e) {
      print(e);
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
        JSON_RPC_UNSUBSCRIBE,
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
    messageTracker!.deleteSubscriptionMessages(topic);
  }

  @override
  Future<void> connect(String? relayUrl) async {
    _checkInitialized();

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
    var auth = await core.crypto.signJWT(core.relayUrl);
    socket = WebSocketChannel.connect(
      Uri.parse(
        MiscUtils.formatRelayRpcUrl(
          PROTOCOL,
          VERSION,
          core.relayUrl,
          '1.0.0',
          auth,
          core.projectId,
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
    print('got publish');
    // If we want to ignore the message, stop
    if (await _shouldIgnoreMessageEvent(topic, message)) return false;

    // Record a message event
    await messageTracker!.recordMessageEvent(topic, message);

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

  Future<bool> _shouldIgnoreMessageEvent(String topic, String message) async {
    if (!await _isSubscribed(topic)) return true;
    return messageTracker!.messageIsRecorded(topic, message);
  }

  /// SUBSCRIPTION HANDLING

  Future<int> _onSubscribe(String topic) async {
    int? requestId;
    try {
      requestId = await jsonRPC.sendRequest(
        JSON_RPC_SUBSCRIBE,
        {
          'topic': topic,
        },
      );
    } catch (e) {
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    if (requestId == null) {
      return -1;
    }

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
