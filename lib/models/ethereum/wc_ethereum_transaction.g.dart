// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_ethereum_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCEthereumTransaction _$WCEthereumTransactionFromJson(
        Map<String, dynamic> json) =>
    WCEthereumTransaction(
      from: json['from'] as String,
      to: json['to'] as String?,
      nonce: json['nonce'] as String?,
      gasPrice: json['gasPrice'] as String?,
      maxFeePerGas: json['maxFeePerGas'] as String?,
      maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String?,
      gas: json['gas'] as String?,
      gasLimit: json['gasLimit'] as String?,
      value: json['value'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$WCEthereumTransactionToJson(
        WCEthereumTransaction instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'nonce': instance.nonce,
      'gasPrice': instance.gasPrice,
      'maxFeePerGas': instance.maxFeePerGas,
      'maxPriorityFeePerGas': instance.maxPriorityFeePerGas,
      'gas': instance.gas,
      'gasLimit': instance.gasLimit,
      'value': instance.value,
      'data': instance.data,
    };
