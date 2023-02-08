import 'package:wallet_connect_v2_dart/apis/models/basic_errors.dart';
import 'package:wallet_connect_v2_dart/apis/utils/constants.dart';

class SigningMethods {
  static const WC_SESSION_PROPOSE = 'wc_sessionPropose';
  static const WC_SESSION_SETTLE = 'wc_pairingDelete';
  static const WC_SESSION_UPDATE = 'wc_sessionUpdate';
  static const WC_SESSION_EXTEND = 'wc_sessionExtend';
  static const WC_SESSION_REQUEST = 'wc_sessionRequest';
  static const WC_SESSION_EVENT = 'wc_sessionEvent';
  static const WC_SESSION_DELETE = 'wc_sessionDelete';
  static const WC_SESSION_PING = 'wc_sessionPing';

  static const Map<String, dynamic> RPC_OPTS = {
    WC_SESSION_PROPOSE: {
      "req": RpcOptions(WalletConnectConstants.FIVE_MINUTES, true, 1100),
      "res": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1101),
    },
    WC_SESSION_SETTLE: {
      "req": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1102),
      "res": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1103),
    },
    WC_SESSION_UPDATE: {
      "req": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1104),
      "res": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1105),
    },
    WC_SESSION_EXTEND: {
      "req": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1106),
      "res": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1107),
    },
    WC_SESSION_REQUEST: {
      "req": RpcOptions(WalletConnectConstants.FIVE_MINUTES, true, 1108),
      "res": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1109),
    },
    WC_SESSION_EVENT: {
      "req": RpcOptions(WalletConnectConstants.FIVE_MINUTES, true, 1110),
      "res": RpcOptions(WalletConnectConstants.FIVE_MINUTES, false, 1111),
    },
    WC_SESSION_DELETE: {
      "req": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1112),
      "res": RpcOptions(WalletConnectConstants.ONE_DAY, false, 1113),
    },
    WC_SESSION_PING: {
      "req": RpcOptions(WalletConnectConstants.THIRTY_SECONDS, false, 1114),
      "res": RpcOptions(WalletConnectConstants.THIRTY_SECONDS, false, 1115),
    },
  };
}
