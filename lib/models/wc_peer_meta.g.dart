// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_peer_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WCPeerMeta _$$_WCPeerMetaFromJson(Map<String, dynamic> json) =>
    _$_WCPeerMeta(
      name: json['name'] as String,
      url: json['url'] as String,
      description: json['description'] as String,
      icons:
          (json['icons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$_WCPeerMetaToJson(_$_WCPeerMeta instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'description': instance.description,
      'icons': instance.icons,
    };
