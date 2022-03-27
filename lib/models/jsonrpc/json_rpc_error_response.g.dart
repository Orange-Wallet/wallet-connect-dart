// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JsonRpcErrorResponse _$$_JsonRpcErrorResponseFromJson(
        Map<String, dynamic> json) =>
    _$_JsonRpcErrorResponse(
      id: json['id'] as int,
      error: JsonRpcError.fromJson(json['error'] as Map<String, dynamic>),
      jsonrpc: json['jsonrpc'] as String? ?? JSONRPC_VERSION,
    );

Map<String, dynamic> _$$_JsonRpcErrorResponseToJson(
        _$_JsonRpcErrorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'error': instance.error.toJson(),
      'jsonrpc': instance.jsonrpc,
    };
