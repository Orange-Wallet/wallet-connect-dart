// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_encryption_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCEncryptionPayload _$WCEncryptionPayloadFromJson(Map<String, dynamic> json) =>
    WCEncryptionPayload(
      data: json['data'] as String,
      hmac: json['hmac'] as String,
      iv: json['iv'] as String,
    );

Map<String, dynamic> _$WCEncryptionPayloadToJson(
        WCEncryptionPayload instance) =>
    <String, dynamic>{
      'data': instance.data,
      'hmac': instance.hmac,
      'iv': instance.iv,
    };
