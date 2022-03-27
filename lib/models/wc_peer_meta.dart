import 'package:freezed_annotation/freezed_annotation.dart';

part 'wc_peer_meta.freezed.dart';
part 'wc_peer_meta.g.dart';

@immutable
@freezed
class WCPeerMeta with _$WCPeerMeta {
  factory WCPeerMeta({
    required String name,
    required String url,
    required String description,
    @Default([]) List<String> icons,
  }) = _WCPeerMeta;

  factory WCPeerMeta.fromJson(Map<String, dynamic> json) =>
      _$WCPeerMetaFromJson(json);
}
