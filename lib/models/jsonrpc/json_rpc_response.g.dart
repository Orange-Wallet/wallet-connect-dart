// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcResponse<T> _$JsonRpcResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    JsonRpcResponse<T>(
      id: json['id'] as int,
      jsonrpc: json['jsonrpc'] as String? ?? JSONRPC_VERSION,
      error: json['error'] == null ? null : JsonRpcError.fromJson(json['error'] as Map<String, dynamic>),
      result: _$nullableGenericFromJson(json['result'], fromJsonT),
    );

Map<String, dynamic> _$JsonRpcResponseToJson<T>(
  JsonRpcResponse<T> instance,
  Object? Function(T value) toJsonT,
) {
  if (instance.error == null) return <String, dynamic>{
    'id': instance.id,
    'jsonrpc': instance.jsonrpc,
    'result': _$nullableGenericToJson(instance.result, toJsonT),
  };

  return <String, dynamic>{
    'id': instance.id,
    'jsonrpc': instance.jsonrpc,
    'error': instance.error,
    'result': _$nullableGenericToJson(instance.result, toJsonT),
  };
}


T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
