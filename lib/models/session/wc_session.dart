import 'package:freezed_annotation/freezed_annotation.dart';

part 'wc_session.freezed.dart';
part 'wc_session.g.dart';

@immutable
@freezed
class WCSession with _$WCSession {
  const WCSession._();

  const factory WCSession({
    required String topic,
    required String version,
    required String bridge,
    required String key,
  }) = SessionData;

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

  const factory WCSession.empty({
    @Default('') String topic,
    @Default('') String version,
    @Default('') String bridge,
    @Default('') String key,
  }) = EmptyWCSession;

  factory WCSession.fromJson(Map<String, dynamic> json) =>
      _$WCSessionFromJson(json);
}
