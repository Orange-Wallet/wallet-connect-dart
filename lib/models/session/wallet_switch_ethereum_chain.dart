import 'package:json_annotation/json_annotation.dart';

part 'wallet_switch_ethereum_chain.g.dart';

@JsonSerializable()
class WalletSwitchEthereumChain {
  final String chainId;

  WalletSwitchEthereumChain({required this.chainId});

  factory WalletSwitchEthereumChain.fromJson(Map<String, dynamic> json) =>
      _$WalletSwitchEthereumChainFromJson(json);

  Map<String, dynamic> toJson() => _$WalletSwitchEthereumChainToJson(this);

  @override
  String toString() => 'WalletSwitchEthereumChain(chainId: $chainId)';
}
