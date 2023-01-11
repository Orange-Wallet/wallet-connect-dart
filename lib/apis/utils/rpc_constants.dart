import 'package:wallet_connect_v2/apis/models/basic_errors.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';

class RPCConstants {
  static const WC_PAIRING_PING = 'wc_pairingPing';
  static const WC_PAIRING_DELETE = 'wc_pairingDelete';
  static const UNREGISTERED_METHOD = 'unregistered_method';

  static final Map<String, dynamic> PAIRING_RPC_OPTS = {
    WC_PAIRING_PING: {
      'req': RpcOptions(
        WalletConnectConstants.ONE_DAY,
        false,
        1000,
      ),
      'res': RpcOptions(
        WalletConnectConstants.ONE_DAY,
        false,
        1001,
      ),
    },
    WC_PAIRING_DELETE: {
      'req': RpcOptions(
        WalletConnectConstants.THIRTY_SECONDS,
        false,
        1002,
      ),
      'res': RpcOptions(
        WalletConnectConstants.THIRTY_SECONDS,
        false,
        1003,
      ),
    },
    UNREGISTERED_METHOD: {
      'req': RpcOptions(
        WalletConnectConstants.ONE_DAY,
        false,
        0,
      ),
      'res': RpcOptions(
        WalletConnectConstants.ONE_DAY,
        false,
        0,
      ),
    },
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
