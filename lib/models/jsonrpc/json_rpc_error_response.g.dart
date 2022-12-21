// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcErrorResponse _$JsonRpcErrorResponseFromJson(
        Map<String, dynamic> json) =>
    JsonRpcErrorResponse(
      id: json['id'] as int,
      error: json['error'],
    );

Map<String, dynamic> _$JsonRpcErrorResponseToJson(
        JsonRpcErrorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'error': instance.error,
    };
