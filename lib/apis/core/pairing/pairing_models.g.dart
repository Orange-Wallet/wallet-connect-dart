// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PairingInfo _$PairingInfoFromJson(Map<String, dynamic> json) => PairingInfo(
      json['topic'] as String,
      json['expiry'] as int,
      Relay.fromJson(json['relay'] as Map<String, dynamic>),
      json['active'] as bool,
      peerMetadata: json['peerMetadata'] == null
          ? null
          : PairingMetadata.fromJson(
              json['peerMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PairingInfoToJson(PairingInfo instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'expiry': instance.expiry,
      'relay': instance.relay,
      'active': instance.active,
      'peerMetadata': instance.peerMetadata,
    };

PairingMetadata _$PairingMetadataFromJson(Map<String, dynamic> json) =>
    PairingMetadata(
      json['name'] as String,
      json['description'] as String,
      json['url'] as String,
      (json['icons'] as List<dynamic>).map((e) => e as String).toList(),
      json['redirect'] == null
          ? null
          : Redirect.fromJson(json['redirect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PairingMetadataToJson(PairingMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'icons': instance.icons,
      'redirect': instance.redirect,
    };

Redirect _$RedirectFromJson(Map<String, dynamic> json) => Redirect(
      json['native'] as String?,
      json['universal'] as String?,
    );

Map<String, dynamic> _$RedirectToJson(Redirect instance) => <String, dynamic>{
      'native': instance.native,
      'universal': instance.universal,
    };
