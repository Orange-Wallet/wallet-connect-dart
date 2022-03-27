// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_encryption_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WCEncryptionPayload _$$_WCEncryptionPayloadFromJson(
        Map<String, dynamic> json) =>
    _$_WCEncryptionPayload(
      data: json['data'] as String,
      hmac: json['hmac'] as String,
      iv: json['iv'] as String,
    );

Map<String, dynamic> _$$_WCEncryptionPayloadToJson(
        _$_WCEncryptionPayload instance) =>
    <String, dynamic>{
      'data': instance.data,
      'hmac': instance.hmac,
      'iv': instance.iv,
    };
