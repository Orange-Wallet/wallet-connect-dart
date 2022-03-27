import 'package:freezed_annotation/freezed_annotation.dart';

part 'wc_ethereum_transaction.freezed.dart';
part 'wc_ethereum_transaction.g.dart';

@immutable
@freezed
class WCEthereumTransaction with _$WCEthereumTransaction {
  factory WCEthereumTransaction({
    required String from,
    required String to,
    String? nonce,
    String? gasPrice,
    String? gas,
    String? gasLimit,
    String? value,
    required String data,
  }) = _WCEthereumTransaction;

  factory WCEthereumTransaction.fromJson(Map<String, dynamic> json) =>
      _$WCEthereumTransactionFromJson(json);
}
