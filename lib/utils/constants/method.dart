import 'package:wallet_connect/models/basic_models.dart';
import 'package:wallet_connect/utils/constants/constants.dart';

class MethodConstants {
  static const WC_PAIRING_PING = 'wc_pairingPing';
  static const WC_PAIRING_DELETE = 'wc_pairingDelete';
  static const UNREGISTERED_METHOD = 'unregistered_method';

  static const WC_SESSION_PROPOSE = 'wc_sessionPropose';
  static const WC_SESSION_SETTLE = 'wc_sessionSettle';
  static const WC_SESSION_UPDATE = 'wc_sessionUpdate';
  static const WC_SESSION_EXTEND = 'wc_sessionExtend';
  static const WC_SESSION_REQUEST = 'wc_sessionRequest';
  static const WC_SESSION_EVENT = 'wc_sessionEvent';
  static const WC_SESSION_DELETE = 'wc_sessionDelete';
  static const WC_SESSION_PING = 'wc_sessionPing';

  static const WC_AUTH_REQUEST = 'wc_authRequest';

  static const Map<String, Map<String, RpcOptions>> RPC_OPTS = {
    WC_PAIRING_PING: {
      'req': RpcOptions(ONE_DAY, false, 1000),
      'res': RpcOptions(ONE_DAY, false, 1001),
    },
    WC_PAIRING_DELETE: {
      'req': RpcOptions(THIRTY_SECONDS, false, 1002),
      'res': RpcOptions(THIRTY_SECONDS, false, 1003),
    },
    UNREGISTERED_METHOD: {
      'req': RpcOptions(ONE_DAY, false, 0),
      'res': RpcOptions(ONE_DAY, false, 0),
    },
    WC_SESSION_PROPOSE: {
      "req": RpcOptions(FIVE_MINUTES, true, 1100),
      "res": RpcOptions(FIVE_MINUTES, false, 1101),
    },
    WC_SESSION_SETTLE: {
      "req": RpcOptions(FIVE_MINUTES, false, 1102),
      "res": RpcOptions(FIVE_MINUTES, false, 1103),
    },
    WC_SESSION_UPDATE: {
      "req": RpcOptions(ONE_DAY, false, 1104),
      "res": RpcOptions(ONE_DAY, false, 1105),
    },
    WC_SESSION_EXTEND: {
      "req": RpcOptions(ONE_DAY, false, 1106),
      "res": RpcOptions(ONE_DAY, false, 1107),
    },
    WC_SESSION_REQUEST: {
      "req": RpcOptions(FIVE_MINUTES, true, 1108),
      "res": RpcOptions(FIVE_MINUTES, false, 1109),
    },
    WC_SESSION_EVENT: {
      "req": RpcOptions(FIVE_MINUTES, true, 1110),
      "res": RpcOptions(FIVE_MINUTES, false, 1111),
    },
    WC_SESSION_DELETE: {
      "req": RpcOptions(ONE_DAY, false, 1112),
      "res": RpcOptions(ONE_DAY, false, 1113),
    },
    WC_SESSION_PING: {
      "req": RpcOptions(THIRTY_SECONDS, false, 1114),
      "res": RpcOptions(THIRTY_SECONDS, false, 1115),
    },
    WC_AUTH_REQUEST: {
      "req": RpcOptions(ONE_DAY, true, 3000),
      "res": RpcOptions(ONE_DAY, false, 3001),
    },
  };
}
