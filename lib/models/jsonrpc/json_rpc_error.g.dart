// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RpcError _$$RpcErrorFromJson(Map<String, dynamic> json) => _$RpcError(
      json['code'] as int,
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RpcErrorToJson(_$RpcError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$ServerError _$$ServerErrorFromJson(Map<String, dynamic> json) =>
    _$ServerError(
      json['message'] as String,
      code: json['code'] as int? ?? -32000,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ServerErrorToJson(_$ServerError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'runtimeType': instance.$type,
    };

_$InvalidParams _$$InvalidParamsFromJson(Map<String, dynamic> json) =>
    _$InvalidParams(
      json['message'] as String,
      code: json['code'] as int? ?? -32602,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InvalidParamsToJson(_$InvalidParams instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'runtimeType': instance.$type,
    };

_$InvalidRequest _$$InvalidRequestFromJson(Map<String, dynamic> json) =>
    _$InvalidRequest(
      json['message'] as String,
      code: json['code'] as int? ?? -32600,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InvalidRequestToJson(_$InvalidRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'runtimeType': instance.$type,
    };

_$ParseError _$$ParseErrorFromJson(Map<String, dynamic> json) => _$ParseError(
      json['message'] as String,
      code: json['code'] as int? ?? -32700,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ParseErrorToJson(_$ParseError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'runtimeType': instance.$type,
    };

_$MethodNotFound _$$MethodNotFoundFromJson(Map<String, dynamic> json) =>
    _$MethodNotFound(
      json['message'] as String,
      code: json['code'] as int? ?? -32601,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MethodNotFoundToJson(_$MethodNotFound instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'runtimeType': instance.$type,
    };
