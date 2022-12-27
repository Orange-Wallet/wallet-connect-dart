// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionMetadata _$ConnectionMetadataFromJson(Map<String, dynamic> json) =>
    ConnectionMetadata(
      json['publicKey'] as String,
      PairingMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectionMetadataToJson(ConnectionMetadata instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'metadata': instance.metadata,
    };
