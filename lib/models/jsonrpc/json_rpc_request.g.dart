// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) =>
    JsonRpcRequest(
      id: JsonRpcRequest._idFromValue(json['id']),
      jsonrpc: json['jsonrpc'] as String? ?? JSONRPC_VERSION,
      method: $enumDecodeNullable(_$WCMethodEnumMap, json['method'],
          unknownValue: JsonKey.nullForUndefinedEnumValue),
      params: json['params'] as List<dynamic>?,
    );

Map<String, dynamic> _$JsonRpcRequestToJson(JsonRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': _$WCMethodEnumMap[instance.method],
      'params': instance.params,
    };

const _$WCMethodEnumMap = {
  WCMethod.SESSION_REQUEST: 'wc_sessionRequest',
  WCMethod.SESSION_UPDATE: 'wc_sessionUpdate',
  WCMethod.ETH_SIGN: 'eth_sign',
  WCMethod.ETH_PERSONAL_SIGN: 'personal_sign',
  WCMethod.ETH_SIGN_TYPE_DATA: 'eth_signTypedData',
  WCMethod.ETH_SIGN_TRANSACTION: 'eth_signTransaction',
  WCMethod.ETH_SEND_TRANSACTION: 'eth_sendTransaction',
  WCMethod.WALLET_SWITCH_NETWORK: 'wallet_switchEthereumChain',
};
