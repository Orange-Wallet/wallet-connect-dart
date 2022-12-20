import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/models/models.dart';

abstract class IPairing {
  Future<void> init();
  Future<PairingInfo> pair(
    String uri,
    bool? activatePairing,
  );
  Future<CreateResponse> create();
  Future<void> activate(String topic);
  void register(List<String> methods);
  Future<void> updateExpiry(String topic, int expiry);
  Future<void> updateMetadata(String topic, PairingMetadata metadata);
  List<PairingInfo> getPairings();
  Future<void> ping(String topic);
  Future<void> disconnect(String topic);
}
