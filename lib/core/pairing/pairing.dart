import 'dart:async';
import 'dart:convert';

import 'package:event/event.dart';

import 'package:wallet_connect/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect/core/crypto/crypto_models.dart';
import 'package:wallet_connect/core/i_core.dart';
import 'package:wallet_connect/core/pairing/i_pairing.dart';
import 'package:wallet_connect/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/core/pairing/pairing_store.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_utils.dart';
import 'package:wallet_connect/core/store/generic_store.dart';
import 'package:wallet_connect/core/store/i_generic_store.dart';
import 'package:wallet_connect/models/apis/json_rpc_request.dart';
import 'package:wallet_connect/models/basic_models.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_error.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_response.dart';
import 'package:wallet_connect/models/uri_parse_result.dart';
import 'package:wallet_connect/utils/constants/constants.dart';
import 'package:wallet_connect/utils/constants/errors.dart';
import 'package:wallet_connect/utils/constants/method.dart';
import 'package:wallet_connect/utils/walletconnect_utils.dart';

class Pairing implements IPairing {
  bool _initialized = false;

  @override
  final Event<PairingEvent> onPairingCreate = Event<PairingEvent>();
  @override
  final Event<PairingActivateEvent> onPairingActivate = Event<PairingActivateEvent>();
  @override
  final Event<PairingEvent> onPairingPing = Event<PairingEvent>();
  @override
  final Event<PairingInvalidEvent> onPairingInvalid = Event<PairingInvalidEvent>();
  @override
  final Event<PairingEvent> onPairingDelete = Event<PairingEvent>();
  @override
  final Event<PairingEvent> onPairingExpire = Event<PairingEvent>();

  /// Stores all the pending requests
  Map<int, Completer> pendingRequests = {};

  ICore core;
  IPairingStore? pairings;

  /// Stores the public key of Type 1 Envelopes for a topic
  /// Once a receiver public key has been used, it is removed from the store
  /// Thus, this store works under the assumption that a public key will only be used once
  late IGenericStore<String> topicToReceiverPublicKey;

  Pairing(
    this.core, {
    this.pairings,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    _registerRelayEvents();
    _registerExpirerEvents();

    pairings ??= PairingStore(core);
    topicToReceiverPublicKey = GenericStore(
      core: core,
      context: 'topicToReceiverPublicKey',
      version: '1.0',
      toJson: (String value) {
        return value;
      },
      fromJson: (dynamic value) {
        return value as String;
      },
    );

    await core.expirer.init();
    await pairings!.init();
    await topicToReceiverPublicKey.init();

    await _cleanup();

    // Resubscribe to all active pairings
    final List<PairingInfo> activePairings = pairings!.getAll();
    for (final PairingInfo pairing in activePairings) {
      if (pairing.active) {
        await core.relayClient.subscribe(topic: pairing.topic);
      }
    }

    _initialized = true;
  }

  @override
  Future<CreateResponse> create({
    List<List<String>>? methods,
  }) async {
    _checkInitialized();
    final String symKey = core.crypto.getUtils().generateRandomBytes32();
    final String topic = await core.crypto.setSymKey(symKey);
    final int expiry = WalletConnectUtils.calculateExpiry(
      FIVE_MINUTES,
    );
    final Relay relay = Relay(RELAYER_DEFAULT_PROTOCOL);
    final PairingInfo pairing = PairingInfo(
      topic: topic,
      expiry: expiry,
      relay: relay,
      active: false,
    );
    final Uri uri = WalletConnectUtils.formatUri(
      protocol: core.protocol,
      version: core.version,
      topic: topic,
      symKey: symKey,
      relay: relay,
      methods: methods,
    );

    onPairingCreate.broadcast(
      PairingEvent(
        topic: topic,
      ),
    );

    await pairings!.set(topic, pairing);
    await core.relayClient.subscribe(topic: topic);
    await core.expirer.set(topic, expiry);

    return CreateResponse(
      topic: topic,
      uri: uri,
      pairingInfo: pairing,
    );
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
    bool activatePairing = false,
  }) async {
    _checkInitialized();

    // print(uri.queryParameters);
    final int expiry = WalletConnectUtils.calculateExpiry(
      FIVE_MINUTES,
    );
    final URIParseResult parsedUri = WalletConnectUtils.parseUri(uri);
    final String topic = parsedUri.topic;
    final Relay relay = parsedUri.relay;
    final String symKey = parsedUri.symKey;
    final PairingInfo pairing = PairingInfo(
      topic: topic,
      expiry: expiry,
      relay: relay,
      active: false,
    );

    try {
      PairingUtils.validateMethods(
        parsedUri.methods,
        routerMapRequest.values.toList(),
      );
    } on WalletConnectError catch (e) {
      // Tell people that the pairing is invalid
      onPairingInvalid.broadcast(
        PairingInvalidEvent(
          message: e.message,
        ),
      );

      rethrow;
    }

    await pairings!.set(topic, pairing);
    await core.crypto.setSymKey(symKey, overrideTopic: topic);
    await core.relayClient.subscribe(topic: topic);
    await core.expirer.set(topic, expiry);

    onPairingCreate.broadcast(PairingEvent(topic: topic));

    if (activatePairing) await activate(topic: topic);

    return pairing;
  }

  @override
  Future<void> activate({required String topic}) async {
    _checkInitialized();
    final int expiry = WalletConnectUtils.calculateExpiry(THIRTY_DAYS);

    await pairings!.update(
      topic,
      expiry: expiry,
      active: true,
    );
    await core.expirer.set(topic, expiry);
  }

  @override
  void register({
    required String method,
    required Function(String, JsonRpcRequest) function,
    required ProtocolType type,
  }) {
    if (routerMapRequest.containsKey(method)) {
      throw WalletConnectError(
        code: -1,
        message: 'Method already exists',
      );
    }

    routerMapRequest[method] = RegisteredFunction(
      method: method,
      function: function,
      type: type,
    );
  }

  @override
  Future<void> setReceiverPublicKey({
    required String topic,
    required String publicKey,
    int? expiry,
  }) async {
    _checkInitialized();
    await topicToReceiverPublicKey.set(topic, publicKey);
    await core.expirer.set(
      publicKey,
      WalletConnectUtils.calculateExpiry(
        expiry ?? FIVE_MINUTES,
      ),
    );
  }

  @override
  Future<void> updateExpiry({
    required String topic,
    required int expiry,
  }) async {
    _checkInitialized();

    // Validate the expiry is less than 30 days
    if (expiry > WalletConnectUtils.calculateExpiry(THIRTY_DAYS)) {
      throw WalletConnectError(
        code: -1,
        message: 'Expiry cannot be more than 30 days away',
      );
    }

    onPairingActivate.broadcast(
      PairingActivateEvent(
        topic: topic,
        expiry: expiry,
      ),
    );

    await pairings!.update(topic, expiry: expiry);
    await core.expirer.set(topic, expiry);
  }

  @override
  Future<void> updateMetadata({
    required String topic,
    required PairingMetadata metadata,
  }) async {
    _checkInitialized();
    await pairings!.update(
      topic,
      metadata: metadata,
    );
  }

  @override
  List<PairingInfo> getPairings() {
    return pairings!.getAll();
  }

  @override
  Future<void> ping({required String topic}) async {
    _checkInitialized();

    await _isValidPing(topic);

    if (pairings!.has(topic)) {
      // try {
      final bool _ = await sendRequest(
        topic,
        MethodConstants.WC_PAIRING_PING,
        {},
      );
    }
  }

  @override
  Future<void> disconnect({required String topic}) async {
    _checkInitialized();

    await _isValidDisconnect(topic);
    if (pairings!.has(topic)) {
      // Send the request to delete the pairing, we don't care if it fails
      try {
        sendRequest(
          topic,
          MethodConstants.WC_PAIRING_DELETE,
          Errors.getSdkError(Errors.USER_DISCONNECTED).toJson(),
        );
      } catch (_) {}

      // Delete the pairing
      await pairings!.delete(topic);

      onPairingDelete.broadcast(
        PairingEvent(
          topic: topic,
        ),
      );
    }
  }

  @override
  IPairingStore getStore() {
    return pairings!;
  }

  Future<void> isValidPairingTopic({required String topic}) async {
    if (!pairings!.has(topic)) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "pairing topic doesn't exist: $topic",
      );
    }

    if (await core.expirer.checkAndExpire(topic)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: "pairing topic: $topic",
      );
    }
  }

  // RELAY COMMUNICATION HELPERS

  Future sendRequest(
    String topic,
    String method,
    Map<String, dynamic> params, {
    int? id,
    int? ttl,
    EncodeOptions? encodeOptions,
  }) async {
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcRequest(
      method,
      params,
      id: id,
    );
    final JsonRpcRequest request = JsonRpcRequest.fromJson(payload);

    final String? message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );

    if (message == null) {
      return;
    }

    RpcOptions opts = MethodConstants.RPC_OPTS[method]!['req']!;
    if (ttl != null) {
      opts = opts.copyWith(ttl: ttl);
    }
    await core.history.set(
      topic,
      request,
    );
    // print('sent request');
    await core.relayClient.publish(
      topic: topic,
      message: message,
      ttl: opts.ttl,
      tag: opts.tag,
    );
    final Completer completer = Completer();
    pendingRequests[payload['id']] = completer;

    // Get the result from the completer, if it's an error, throw it
    try {
      final result = await completer.future;
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendResult(
    int id,
    String topic,
    String method,
    dynamic result, {
    EncodeOptions? encodeOptions,
  }) async {
    // print('sending result');
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcResponse(
      id,
      result,
    );
    final String? message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );

    if (message == null) return;

    final RpcOptions opts = MethodConstants.RPC_OPTS[method]!['res']!;
    await core.relayClient.publish(
      topic: topic,
      message: message,
      ttl: opts.ttl,
      tag: opts.tag,
    );
    // await core.history.resolve(payload);
  }

  Future<void> sendError(
    int id,
    String topic,
    String method,
    JsonRpcError error, {
    EncodeOptions? encodeOptions,
  }) async {
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcError(
      id,
      error,
    );
    final String? message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );

    if (message == null) return;

    final RpcOptions opts = MethodConstants.RPC_OPTS.containsKey(method)
        ? MethodConstants.RPC_OPTS[method]!['res']!
        : MethodConstants.RPC_OPTS[MethodConstants.UNREGISTERED_METHOD]!['res']!;
    await core.relayClient.publish(
      topic: topic,
      message: message,
      ttl: opts.ttl,
      tag: opts.tag,
    );
    await core.history.resolve(payload);
  }

  /// ---- Private Helpers ---- ///

  Future<void> _deletePairing(String topic, bool expirerHasDeleted) async {
    await core.relayClient.unsubscribe(topic: topic);
    await pairings!.delete(topic);
    await core.crypto.deleteSymKey(topic);
    if (expirerHasDeleted) await core.expirer.delete(topic);
  }

  Future<void> _cleanup() async {
    final List<PairingInfo> expiredPairings = getPairings()
      .where(
        (PairingInfo info) => WalletConnectUtils.isExpired(info.expiry),
      )
      .toList();
    expiredPairings.map(
      (PairingInfo e) async => await pairings!.delete(e.topic),
    );

    // Cleanup all of the expired receiver public keys
    final List<String> expiredReceiverPublicKeys = topicToReceiverPublicKey
        .getAll()
        .where((key) => WalletConnectUtils.isExpired(core.expirer.get(key)))
        .toList();
    expiredReceiverPublicKeys.map(
      (String key) async => await topicToReceiverPublicKey.delete(key),
    );
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  /// ---- Relay Event Router ---- ///

  Map<String, RegisteredFunction> routerMapRequest = {};
  // Map<String, Function> routerMapResponse = {};

  void _registerRelayEvents() {
    core.relayClient.onRelayClientMessage.subscribe(_onMessageEvent);

    register(
      method: MethodConstants.WC_PAIRING_PING,
      function: _onPairingPingRequest,
      type: ProtocolType.Pair,
    );
    register(
      method: MethodConstants.WC_PAIRING_DELETE,
      function: _onPairingDeleteRequest,
      type: ProtocolType.Pair,
    );
  }

  void _onMessageEvent(MessageEvent? event) async {
    if (event == null) {
      return;
    }

    // If we have a reciever public key for the topic, use it
    String? receiverPublicKey = topicToReceiverPublicKey.get(event.topic);
    // If there was a public key, delete it. One use.
    if (receiverPublicKey != null) {
      await topicToReceiverPublicKey.delete(event.topic);
    }

    // Decode the message
    String? payloadString = await core.crypto.decode(
      event.topic,
      event.message,
      options: DecodeOptions(
        receiverPublicKey: receiverPublicKey,
      ),
    );

    if (payloadString == null) return;

    Map<String, dynamic> data = jsonDecode(payloadString);

    // If it's an rpc request, handle it
    // print(data);
    if (data.containsKey('method')) {
      final request = JsonRpcRequest.fromJson(data);
      if (routerMapRequest.containsKey(request.method)) {
        routerMapRequest[request.method]!.function(event.topic, request);
      } else {
        _onUnknownRpcMethodRequest(event.topic, request);
      }
    }
    // Otherwise handle it as a response
    else {
      final response = JsonRpcResponse.fromJson(data);
      final JsonRpcRecord? record = core.history.get(response.id);
      if (record == null) return;

      // print('got here');
      if (pendingRequests.containsKey(response.id)) {
        if (response.error != null) {
          pendingRequests.remove(response.id)!.completeError(response.error!);
        } else {
          pendingRequests.remove(response.id)!.complete(response.result);
        }
      }
    }
  }

  Future<void> _onPairingPingRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    final int id = request.id;
    try {
      // print('ping req');
      await _isValidPing(topic);
      await sendResult(
        id,
        topic,
        request.method,
        true,
      );
      onPairingPing.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } on JsonRpcError catch (e) {
      // print(e);
      await sendError(
        id,
        topic,
        request.method,
        e,
      );
    }
  }

  Future<void> _onPairingDeleteRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    // print('delete');
    final int id = request.id;
    try {
      await _isValidDisconnect(topic);
      await sendResult(
        id,
        topic,
        request.method,
        true,
      );
      await pairings!.delete(topic);
      onPairingDelete.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } on JsonRpcError catch (e) {
      await sendError(
        id,
        topic,
        request.method,
        e,
      );
    }
  }

  Future<void> _onUnknownRpcMethodRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    final int id = request.id;
    final String method = request.method;
    try {
      if (routerMapRequest.containsKey(method)) {
        return;
      }
      final String message = Errors.getSdkError(
        Errors.WC_METHOD_UNSUPPORTED,
        context: method,
      ).message;
      await sendError(
        id,
        topic,
        request.method,
        JsonRpcError.methodNotFound(message),
      );
    } on JsonRpcError catch (e) {
      await sendError(id, topic, request.method, e);
    }
  }

  /// ---- Expirer Events ---- ///

  void _registerExpirerEvents() {
    core.expirer.onExpire.subscribe(_onExpired);
  }

  Future<void> _onExpired(ExpirationEvent? event) async {
    if (event == null) {
      return;
    }

    if (pairings!.has(event.target)) {
      // Clean up the pairing
      await _deletePairing(event.target, true);
      onPairingExpire.broadcast(
        PairingEvent(
          topic: event.target,
        ),
      );
    }
  }

  /// ---- Validators ---- ///

  Future<void> _isValidPing(String topic) async {
    await isValidPairingTopic(topic: topic);
  }

  Future<void> _isValidDisconnect(String topic) async {
    await isValidPairingTopic(topic: topic);
  }
}
