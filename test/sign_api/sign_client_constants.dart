import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/signing_models.dart';

class SignClientConstants {
  static const TEST_RELAY_PROTOCOL = "irn";
  static const TEST_RELAY_OPTIONS = {
    "protocol": TEST_RELAY_PROTOCOL,
  };

  static const TEST_ETHEREUM_CHAIN = "eip155:1";
  static const TEST_ARBITRUM_CHAIN = "eip155:42161";
  static const TEST_AVALANCHE_CHAIN = "eip155:43114";

  static const TEST_CHAINS = [
    TEST_ETHEREUM_CHAIN,
    TEST_ARBITRUM_CHAIN,
    TEST_AVALANCHE_CHAIN
  ];
  static const TEST_METHODS = [
    "eth_sendTransaction",
    "eth_signTransaction",
    "personal_sign",
    "eth_signTypedData",
  ];
  static const TEST_EVENTS = ["chainChanged", "accountsChanged"];

  static const TEST_ETHEREUM_ADDRESS =
      "0x3c582121909DE92Dc89A36898633C1aE4790382b";

  static const TEST_ETHEREUM_ACCOUNT =
      "${TEST_ETHEREUM_CHAIN}:${TEST_ETHEREUM_ADDRESS}";
  static const TEST_ARBITRUM_ACCOUNT =
      "${TEST_ARBITRUM_CHAIN}:${TEST_ETHEREUM_ADDRESS}";
  static const TEST_AVALANCHE_ACCOUNT =
      "${TEST_AVALANCHE_CHAIN}:${TEST_ETHEREUM_ADDRESS}";

  static const TEST_ACCOUNTS = [
    TEST_ETHEREUM_ACCOUNT,
    TEST_ARBITRUM_ACCOUNT,
    TEST_AVALANCHE_ACCOUNT
  ];

  static final TEST_REQUIRED_NAMESPACES = {
    "eip155": RequiredNamespace(
      TEST_CHAINS,
      TEST_METHODS,
      TEST_EVENTS,
      [],
    ),
  };

  static final TEST_NAMESPACES = {
    "eip155": Namespace(
      TEST_ACCOUNTS,
      TEST_METHODS,
      TEST_EVENTS,
      [],
    ),
    // {
    //   "methods": TEST_METHODS,
    //   "accounts": TEST_ACCOUNTS,
    //   "events": TEST_EVENTS,
    // },
  };

  static final TEST_NAMESPACES_INVALID_METHODS = {
    "eip155": Namespace(
      TEST_ACCOUNTS,
      ["eth_invalid"],
      TEST_EVENTS,
      [],
    ),
  };
  static final TEST_NAMESPACES_INVALID_CHAIN = {
    "eip1111": {
      Namespace(
        TEST_ACCOUNTS,
        TEST_METHODS,
        TEST_EVENTS,
        [],
      )
    }
  };

  static const TEST_MESSAGE = "My name is John Doe";
  static const TEST_SIGNATURE =
      "0xc8906b32c9f74d0805226ffff5ecd6897ea55cdf58f54a53a2e5b5d5a21fb67f43ef1d4c2ed790a724a1549b4cc40137403048c4aed9825cfd5ba6c1d15bd0721c";

  static const TEST_SIGN_METHOD = "personal_sign";
  static const TEST_SIGN_PARAMS = [
    TEST_MESSAGE,
    TEST_ETHEREUM_ADDRESS,
  ];
  static const TEST_SIGN_REQUEST = {
    "method": TEST_SIGN_METHOD,
    "params": TEST_SIGN_PARAMS
  };

  static const TEST_RANDOM_REQUEST = {"method": "random_method", "params": []};

  static final TEST_CONNECT_PARAMS = ConnectParams(
    TEST_REQUIRED_NAMESPACES,
    '',
    [Relay('irn')],
  );

  static final TEST_APPROVE_PARAMS = ApproveParams(123, TEST_NAMESPACES);

  static final TEST_REJECT_PARAMS = RejectParams(
    123,
    'GENERIC',
  );

  static final TEST_UPDATE_PARAMS = UpdateParams(
    '123',
    WcSessionUpdateRequest(TEST_NAMESPACES),
  );

  static final TEST_REQUEST_PARAMS = RequestParams(
    '123',
    WcSessionRequestRequest(
      TEST_METHODS[0],
      {},
      TEST_CHAINS[0],
    ),
    TEST_CHAINS[0],
  );

  static const TEST_RESPOND_PARAMS = {
    "response": {
      "id": 1,
      "jsonrpc": "2.0",
      "result": {},
    },
  };

  static final TEST_EMIT_PARAMS = {
    "event": {"name": TEST_EVENTS[0], "data": ""},
    "chainId": TEST_CHAINS[0],
  };
}
