// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcError _$JsonRpcErrorFromJson(Map<String, dynamic> json) => JsonRpcError(
      json['code'] as int,
      json['message'] as String,
    );

Map<String, dynamic> _$JsonRpcErrorToJson(JsonRpcError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
