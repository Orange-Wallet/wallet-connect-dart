import 'package:event/event.dart';

import 'package:wallet_connect/core/crypto/crypto_models.dart';
import 'package:wallet_connect/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/models/apis/json_rpc_request.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_error.dart';

abstract class IPairing {
  abstract final Event<PairingEvent> onPairingCreate;
  abstract final Event<PairingActivateEvent> onPairingActivate;
  abstract final Event<PairingEvent> onPairingPing;
  abstract final Event<PairingInvalidEvent> onPairingInvalid;
  abstract final Event<PairingEvent> onPairingDelete;
  abstract final Event<PairingEvent> onPairingExpire;

  Future<void> init();
  Future<PairingInfo> pair({
    required Uri uri,
    bool activatePairing,
  });
  Future<CreateResponse> create({
    List<List<String>>? methods,
  });
  Future<void> activate({required String topic});
  void register({
    required String method,
    required Function(String, JsonRpcRequest) function,
    required ProtocolType type,
  });
  Future<void> setReceiverPublicKey({
    required String topic,
    required String publicKey,
    int? expiry,
  });
  Future<void> updateExpiry({
    required String topic,
    required int expiry,
  });
  Future<void> updateMetadata({
    required String topic,
    required PairingMetadata metadata,
  });
  List<PairingInfo> getPairings();
  Future<void> ping({required String topic});
  Future<void> disconnect({required String topic});
  IPairingStore getStore();

  Future sendRequest(
    String topic,
    String method,
    Map<String, dynamic> params, {
    int? id,
    int? ttl,
    EncodeOptions? encodeOptions,
  });
  Future<void> sendResult(
    int id,
    String topic,
    String method,
    dynamic result, {
    EncodeOptions? encodeOptions,
  });
  Future<void> sendError(
    int id,
    String topic,
    String method,
    JsonRpcError error, {
    EncodeOptions? encodeOptions,
  });

  Future<void> isValidPairingTopic({
    required String topic,
  });
}
