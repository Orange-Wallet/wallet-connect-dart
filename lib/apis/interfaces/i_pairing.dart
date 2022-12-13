import 'package:wallet_connect_v2/apis/models/models.dart';

class CreatePairingResponse {
  final String topic;
  final String uri;

  CreatePairingResponse(this.topic, this.uri);
}

class ActivatePairingResponse {
  final String topic;

  ActivatePairingResponse(this.topic);
}

abstract class IPairing {
  Future<void> init();
  Future<Pairing> pair();
  Future<CreatePairingResponse> create();
  Future<void> activate(String topic);
  void register(List<String> methods);
  Future<void> updateExpiry(String topic, int expiry);
  Future<void> updateMetadata(String topic, Metadata metadata);
  List<Pairing> getPairings();
  Future<void> ping(String topic);
  Future<void> disconnect(String topic);
}
