// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) {
  return JsonRpcRequest(
    id: json['id'] as int,
    jsonrpc: json['jsonrpc'] as String,
    method: _$enumDecodeNullable(_$WCMethodEnumMap, json['method']),
    params: json['params'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$JsonRpcRequestToJson(JsonRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': _$WCMethodEnumMap[instance.method],
      'params': instance.params,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$WCMethodEnumMap = {
  WCMethod.SESSION_REQUEST: 'wc_sessionRequest',
  WCMethod.SESSION_UPDATE: 'wc_sessionUpdate',
  WCMethod.ETH_SIGN: 'eth_sign',
  WCMethod.ETH_PERSONAL_SIGN: 'personal_sign',
  WCMethod.ETH_SIGN_TYPE_DATA: 'eth_signTypedData',
  WCMethod.ETH_SIGN_TRANSACTION: 'eth_signTransaction',
  WCMethod.ETH_SEND_TRANSACTION: 'eth_sendTransaction',
};
