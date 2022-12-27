import 'package:wallet_connect_v2/apis/models/models.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';

class SessionConstants {
  static final Map<String, Map<String, RpcOptions>> ENGINE_RPC_OPTS = {
    "wc_sessionPropose": {
      "req": RpcOptions(WalletConnectConstants.FIVE_MINUTES, true, 1100),
      "res": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1101),
    },
    "wc_sessionSettle": {
      "req": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1102),
      "res": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1103),
    },
    "wc_sessionUpdate": {
      "req": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1104),
      "res": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1105),
    },
    "wc_sessionExtend": {
      "req": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1106),
      "res": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1107),
    },
    "wc_sessionRequest": {
      "req": RpcOptions(WalletConnectConstants.FIVE_MINUTES, true, 1108),
      "res": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1109),
    },
    "wc_sessionEvent": {
      "req": RpcOptions(WalletConnectConstants.FIVE_MINUTES, true, 1110),
      "res": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1111),
    },
    "wc_sessionDelete": {
      "req": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1112),
      "res": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1113),
    },
    "wc_sessionPing": {
      "req": RpcOptions(WalletConnectConstants.THIRTY_SECONDS, false, 1114),
      "res": RpcOptions(WalletConnectConstants.THIRTY_SECONDS, false, 1115),
    },
  };
}
