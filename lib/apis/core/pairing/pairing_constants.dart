import 'package:wallet_connect_v2/apis/models/models.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';

class PairingConstants {
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
    }
  };
}
