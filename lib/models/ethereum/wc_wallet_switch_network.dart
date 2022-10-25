import 'package:json_annotation/json_annotation.dart';

part 'wc_wallet_switch_network.g.dart';

@JsonSerializable()
class WCWalletSwitchNetwork {
  String chainId;

  WCWalletSwitchNetwork(this.chainId);

  factory WCWalletSwitchNetwork.fromJson(Map<String, dynamic> json) =>
      _$WCWalletSwitchNetworkFromJson(json);
  Map<String, dynamic> toJson() => _$WCWalletSwitchNetworkToJson(this);
}
