import 'package:event/event.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2_dart/apis/models/json_rpc_error.dart';

abstract class IPairing {
  abstract final Event<PairingEvent> onPairingPing;
  abstract final Event<PairingEvent> onPairingDelete;
  abstract final Event<PairingEvent> onPairingExpire;

  Future<void> init();
  Future<PairingInfo> pair(
    Uri uri, {
    bool activatePairing,
  });
  Future<CreateResponse> create();
  Future<void> activate(String topic);
  void register(String method, Function f);
  Future<void> updateExpiry(String topic, int expiry);
  Future<void> updateMetadata(String topic, PairingMetadata metadata);
  List<PairingInfo> getPairings();
  Future<void> ping(String topic);
  Future<void> disconnect(String topic);
  IPairingStore getStore();

  Future sendRequest(
    String topic,
    String method,
    Map<String, dynamic> params, {
    int? id,
  });
  Future<void> sendResult(
    int id,
    String topic,
    String method,
    dynamic result,
  );
  Future<void> sendError(
    int id,
    String topic,
    String method,
    JsonRpcError error,
  );
}
