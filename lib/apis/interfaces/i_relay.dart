import 'package:wallet_connect_v2/apis/models/models.dart';

class PublishOptions {
  final Relay? relay;
  final int? ttl;
  final bool? prompt;
  final int? tag;

  PublishOptions(this.relay, this.ttl, this.prompt, this.tag);
}

class SubscribeOptions {
  final Relay? relay;

  SubscribeOptions(this.relay);
}

class UnsubscribeOptions {
  final String? id;
  final Relay? relay;

  UnsubscribeOptions(this.id, this.relay);
}

abstract class IRelayer {
  Future<void> init();
  Future<void> publish(
    String topic,
    String message,
    PublishOptions? options,
  );
  Future<String> subscribe(String topic, SubscribeOptions? options);
  Future<void> unsubscribe(String topic, UnsubscribeOptions? options);
  Future<void> connect();
  Future<void> disconnect(Relay? relay);
}
