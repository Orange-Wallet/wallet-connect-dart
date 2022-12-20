import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';

class PublishOptions {
  final Relay? relay;
  final int? ttl;
  final bool? prompt;
  final int? tag;

  PublishOptions(this.relay, this.ttl, this.prompt, this.tag);
}

abstract class IRelayClient {
  Future<void> init();
  Future<void> publish(
    String topic,
    String message,
    int ttl, {
    bool? prompt,
    int? tag,
  });
  Future<void> subscribe(String topic);
  Future<void> unsubscribe(String topic);
  Future<void> connect(String? relayUrl);
  Future<void> disconnect();
}
