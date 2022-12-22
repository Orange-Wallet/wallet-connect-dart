import 'dart:convert';

import 'package:event/event.dart';
import 'package:http/http.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_pairing.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_constants.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_store.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_utils.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/core/store/store.dart';
import 'package:wallet_connect_v2/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_v2/apis/models/json_rpc_request.dart';
import 'package:wallet_connect_v2/apis/models/json_rpc_response.dart';
import 'package:wallet_connect_v2/apis/models/models.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';
import 'package:wallet_connect_v2/apis/utils/misc.dart';

class Pairing implements IPairing {
  bool _initialized = false;

  @override
  final Event<PairingEvent> onPairingPing = Event<PairingEvent>();
  @override
  final Event<PairingEvent> onPairingDelete = Event<PairingEvent>();
  @override
  final Event<PairingEvent> onPairingExpire = Event<PairingEvent>();

  ICore core;
  IPairingStore? pairings;

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
    await core.expirer.init();
    await pairings!.init();
    await _cleanup();

    _initialized = true;
  }

  @override
  Future<PairingInfo> pair(
    Uri uri, {
    bool activatePairing = false,
  }) async {
    _checkInitialized();

    // print(uri.queryParameters);
    final int expiry = MiscUtils.calculateExpiry(
      WalletConnectConstants.FIVE_MINUTES,
    );
    final Map<String, dynamic> parsedUri = MiscUtils.parseUri(uri);
    final String topic = parsedUri['topic']!;
    final Relay relay = parsedUri['relay']!;
    final String symKey = uri.queryParameters['symKey']!;
    final PairingInfo pairing = PairingInfo(
      topic,
      expiry,
      relay,
      false,
    );
    await pairings!.set(topic, pairing);
    await core.crypto.setSymKey(symKey, overrideTopic: topic);
    await core.relayClient.subscribe(topic);
    await core.expirer.set(topic, expiry);

    if (activatePairing) {
      await activate(topic);
    }

    return pairing;
  }

  @override
  Future<CreateResponse> create() async {
    _checkInitialized();
    final String symKey = core.crypto.getUtils().generateRandomBytes32();
    final String topic = await core.crypto.setSymKey(symKey);
    final int expiry = MiscUtils.calculateExpiry(
      WalletConnectConstants.FIVE_MINUTES,
    );
    final Relay relay = Relay(WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL);
    final PairingInfo pairing = PairingInfo(topic, expiry, relay, false);
    final Uri uri = MiscUtils.formatUri(
      core.protocol,
      core.version,
      topic,
      symKey,
      relay,
    );
    await pairings!.set(topic, pairing);
    await core.relayClient.subscribe(topic);
    await core.expirer.set(topic, expiry);

    return CreateResponse(
      topic,
      uri,
    );
  }

  @override
  Future<void> activate(String topic) async {
    _checkInitialized();
    final int expiry = MiscUtils.calculateExpiry(
      WalletConnectConstants.THIRTY_DAYS,
    );
    await pairings!.update(
      topic,
      expiry: expiry,
      active: true,
    );
    await core.expirer.set(topic, expiry);
  }

  @override
  void register(String method, Function f) {
    _checkInitialized();

    routerMapRequest[method] = f;
  }

  @override
  Future<void> updateExpiry(String topic, int expiry) async {
    _checkInitialized();
    await pairings!.update(
      topic,
      expiry: expiry,
    );
  }

  @override
  Future<void> updateMetadata(String topic, PairingMetadata metadata) async {
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
  Future<void> ping(String topic) async {
    _checkInitialized();

    _isValidPing(topic);

    if (pairings!.has(topic)) {
      final int id = await _sendRequest(
        topic,
        PairingConstants.WC_PAIRING_PING,
        {},
      );
    }
  }

  @override
  Future<void> disconnect(String topic) async {
    _checkInitialized();

    _isValidDisconnect(topic);
    if (pairings!.has(topic)) {
      await _sendRequest(
        topic,
        PairingConstants.WC_PAIRING_DELETE,
        Errors.getSdkError(Errors.USER_DISCONNECTED).toJson(),
      );
      await pairings!.delete(topic);
    }
  }

  @override
  IPairingStore getStore() {
    return pairings!;
  }

  // PRIVATE HELPERS

  Future<int> _sendRequest(
    String topic,
    String method,
    Map<String, dynamic> params,
  ) async {
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcRequest(
      method,
      params,
    );
    final JsonRpcRequest request = JsonRpcRequest.fromJson(payload);
    final String message = await core.crypto.encode(topic, payload);
    final RpcOptions opts =
        PairingConstants.PAIRING_RPC_OPTS[method]['req'] as RpcOptions;
    await core.history.set(
      topic,
      request,
    );
    // print('sent request');
    await core.relayClient.publish(topic, message, opts.ttl);

    return request.id;
  }

  Future<void> _sendResult(
    int id,
    String topic,
    dynamic result,
  ) async {
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcResponse(
      id,
      result,
    );
    final String message = await core.crypto.encode(topic, payload);
    final JsonRpcRecord? record = core.history.get(id);
    if (record == null) {
      return;
    }
    final RpcOptions opts =
        PairingConstants.PAIRING_RPC_OPTS[record.method]['res'];
    await core.relayClient.publish(topic, message, opts.ttl);
    await core.history.resolve(payload);
  }

  Future<void> _sendError(
    int id,
    String topic,
    JsonRpcError error,
  ) async {
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcError(
      id,
      error,
    );
    final String message = await core.crypto.encode(topic, payload);
    final JsonRpcRecord? record = core.history.get(id);
    if (record == null) {
      return;
    }
    final RpcOptions opts =
        PairingConstants.PAIRING_RPC_OPTS.containsKey(record.method)
            ? PairingConstants.PAIRING_RPC_OPTS[record.method]['res']
            : PairingConstants
                .PAIRING_RPC_OPTS[PairingConstants.UNREGISTERED_METHOD]['res'];
    await core.relayClient.publish(topic, message, opts.ttl);
    await core.history.resolve(payload);
  }

  Future<void> _deletePairing(String topic, bool expirerHasDeleted) async {
    await core.relayClient.unsubscribe(topic);
    await Future.wait([
      pairings!.delete(topic),
      core.crypto.deleteSymKey(topic),
      expirerHasDeleted ? Future.value(null) : core.expirer.delete(topic),
    ]);
  }

  Future<void> _cleanup() async {
    final List<PairingInfo> expiredPairings = getPairings()
        .where(
          (PairingInfo info) => MiscUtils.isExpired(info.expiry),
        )
        .toList();
    expiredPairings.map(
      (PairingInfo e) async => await pairings!.delete(e.topic),
    );
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  /// ---- Relay Event Router ---- ///

  Map<String, Function> routerMapRequest = {};
  Map<String, Function> routerMapResponse = {};

  void _registerRelayEvents() {
    core.relayClient.onRelayClientMessage.subscribe(_onMessageEvent);

    routerMapRequest['wc_pairingPing'] = _onPairingPingRequest;
    routerMapRequest['wc_pairingDelete'] = _onPairingDeleteRequest;
    routerMapResponse['wc_pairingPing'] = _onPairingPingResponse;
  }

  void _onMessageEvent(MessageEvent? event) async {
    // print('message');
    if (event == null) {
      return;
    }

    // Decode the message
    String payloadString = await core.crypto.decode(event.topic, event.message);
    Map<String, dynamic> data = jsonDecode(payloadString);

    // If it's an rpc request, handle it
    if (data.containsKey('method')) {
      final request = JsonRpcRequest.fromJson(data);
      // print(request);
      if (routerMapRequest.containsKey(request.method)) {
        routerMapRequest[request.method]!(event.topic, request);
      } else {
        _onUnkownRpcMethodRequest(event.topic, request);
      }
    }
    // Otherwise handle it as a response
    else if (data.containsKey('result')) {
      final response = JsonRpcResponse.fromJson(data);
      final JsonRpcRecord? record = core.history.get(response.id);
      if (record == null) {
        return;
      }

      if (routerMapRequest.containsKey(record.method)) {
        routerMapRequest[record.method]!(event.topic, response);
      } else {
        _onUnkownRpcMethodResponse(record.method);
      }
    }
  }

  Future<void> _onPairingPingRequest(
      String topic, JsonRpcRequest request) async {
    // print('ping req');
    final int id = request.id;
    try {
      _isValidPing(topic);
      await _sendResult(id, topic, true);
      onPairingPing.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } on JsonRpcError catch (e) {
      await this._sendError(id, topic, e);
    }
  }

  Future<void> _onPairingDeleteRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    // print('delete');
    final int id = request.id;
    try {
      _isValidDisconnect(topic);
      await _sendResult(id, topic, true);
      await pairings!.delete(topic);
      onPairingDelete.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } on JsonRpcError catch (e) {
      await this._sendError(id, topic, e);
    }
  }

  Future<void> _onUnkownRpcMethodRequest(
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
      await _sendError(id, topic, JsonRpcError.methodNotFound(message));
    } on JsonRpcError catch (e) {
      await this._sendError(id, topic, e);
    }
  }

  Future<void> _onPairingPingResponse(
      String topic, JsonRpcResponse response) async {
    final int id = response.id;

    if (!response.result is JsonRpcError) {
      onPairingPing.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } else {
      onPairingPing.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
          error: response.result,
        ),
      );
    }
  }

  void _onUnkownRpcMethodResponse(String method) {
    if (routerMapRequest.containsKey(method)) {
      return;
    }
  }

  /// ---- Expirer Events ---- ///

  void _registerExpirerEvents() {
    core.expirer.expired.subscribe(_onExpired);
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

  void _isValidPing(String topic) {
    _isValidPairingTopic(topic);
  }

  void _isValidDisconnect(String topic) {
    _isValidPairingTopic(topic);
  }

  void _isValidPairingTopic(String topic) {
    if (!pairings!.has(topic)) {
      String message = Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "pairing topic doesn't exist: $topic",
      ).message;
      throw JsonRpcError.invalidParams(message);
    }
    if (MiscUtils.isExpired(pairings!.get(topic)!.expiry)) {
      String message = Errors.getInternalError(
        Errors.EXPIRED,
        context: "pairing topic: $topic",
      ).message;
      throw JsonRpcError.invalidParams(message);
    }
  }
}
