import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wc_peer_meta.g.dart';

@JsonSerializable()
class WCPeerMeta {
  final String name;
  final String url;
  final String description;
  final List<String> icons;
  WCPeerMeta({
    required this.name,
    required this.url,
    required this.description,
    this.icons = const [],
  });

  factory WCPeerMeta.fromJson(Map<String, dynamic> json) =>
      _$WCPeerMetaFromJson(json);

  Map<String, dynamic> toJson() => _$WCPeerMetaToJson(this);

  @override
  String toString() {
    return 'WCPeerMeta(name: $name, url: $url, description: $description, icons: $icons)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WCPeerMeta &&
        other.name == name &&
        other.url == url &&
        other.description == description &&
        listEquals(other.icons, icons);
  }

  @override
  int get hashCode {
    return name.hashCode ^ url.hashCode ^ description.hashCode ^ icons.hashCode;
  }
}
