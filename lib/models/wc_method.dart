import 'package:json_annotation/json_annotation.dart';

enum WCMethod {
  @JsonValue("wc_sessionRequest")
  SESSION_REQUEST,

  @JsonValue("wc_sessionUpdate")
  SESSION_UPDATE,
  
  @JsonValue("wallet_switchEthereumChain")
  SWITCH_ETHEREUM_CHAIN,

  @JsonValue("eth_sign")
  ETH_SIGN,

  @JsonValue("personal_sign")
  ETH_PERSONAL_SIGN,

  @JsonValue("eth_signTypedData")
  ETH_SIGN_TYPE_DATA,

  @JsonValue("eth_signTransaction")
  ETH_SIGN_TRANSACTION,

  @JsonValue("eth_sendTransaction")
  ETH_SEND_TRANSACTION,
}
