import 'package:json_annotation/json_annotation.dart';

part 'wc_ethereum_transaction.g.dart';

@JsonSerializable()
class WCEthereumTransaction {
  final String from;
  final String to;
  final String? nonce;
  final String? gasPrice;
  final String? gas;
  final String? gasLimit;
  final String? value;
  final String data;
  WCEthereumTransaction({
    required this.from,
    required this.to,
    this.nonce,
    this.gasPrice,
    required this.gas,
    this.gasLimit,
    this.value,
    required this.data,
  });

  factory WCEthereumTransaction.fromJson(Map<String, dynamic> json) =>
      _$WCEthereumTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$WCEthereumTransactionToJson(this);

  @override
  String toString() {
    return 'WCEthereumTransaction(from: $from, to: $to, nonce: $nonce, gasPrice: $gasPrice, gas: $gas, gasLimit: $gasLimit, value: $value, data: $data)';
  }
}
