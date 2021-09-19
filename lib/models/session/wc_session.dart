import 'package:json_annotation/json_annotation.dart';

part 'wc_session.g.dart';

@JsonSerializable()
class WCSession {
  final String topic;
  final String version;
  final String bridge;
  final String key;
  WCSession({
    required this.topic,
    required this.version,
    required this.bridge,
    required this.key,
  });

  String toUri() => "wc:$topic@$version?bridge=$bridge&key=$key";

  factory WCSession.from(String wcUri) {
    if (!wcUri.startsWith("wc:")) {
      return WCSession.empty();
    }

    final uriString = wcUri.replaceAll("wc:", "wc://");
    final uri = Uri.parse(uriString);
    final bridge = uri.queryParameters["bridge"];
    final key = uri.queryParameters["key"];
    final topic = uri.userInfo;
    final version = uri.host;

    if (bridge == null || key == null) {
      return WCSession.empty();
    }

    return WCSession(topic: topic, version: version, bridge: bridge, key: key);
  }

  factory WCSession.empty() =>
      WCSession(topic: '', version: '', bridge: '', key: '');

  factory WCSession.fromJson(Map<String, dynamic> json) =>
      _$WCSessionFromJson(json);
  Map<String, dynamic> toJson() => _$WCSessionToJson(this);

  @override
  String toString() {
    return 'WCSession(topic: $topic, version: $version, bridge: $bridge, key: $key)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WCSession &&
        other.topic == topic &&
        other.version == version &&
        other.bridge == bridge &&
        other.key == key;
  }

  @override
  int get hashCode {
    return topic.hashCode ^ version.hashCode ^ bridge.hashCode ^ key.hashCode;
  }
}
