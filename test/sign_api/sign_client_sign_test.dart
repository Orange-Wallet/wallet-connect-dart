import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/signing_models.dart';
import 'package:wallet_connect_v2/wallet_connect_v2.dart';

import 'sign_client_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const TEST_RELAY_URL = 'ws://0.0.0.0:5555';
  const TEST_PROJECT_ID = '7e984f90b95f0236d3c12d791537f233';

  group('Signing API', () {
    late SignClient clientA;
    late SignClient clientB;

    setUp(() async {
      clientA = await SignClient.createInstance(
        Core(
          TEST_RELAY_URL,
          TEST_PROJECT_ID,
          memoryStore: true,
        ),
        self: PairingMetadata(
          'App A (Proposer, dapp)',
          'Description of Proposer App run by client A',
          'https://walletconnect.com',
          ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
      clientB = await SignClient.createInstance(
        Core(
          TEST_RELAY_URL,
          TEST_PROJECT_ID,
          memoryStore: true,
        ),
        self: PairingMetadata(
          'App B (Responder, Wallet)',
          'Description of Proposer App run by client B',
          'https://walletconnect.com',
          ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
    });

    tearDown(() async {
      await clientA.core.relayClient.disconnect();
      await clientA.core.relayClient.disconnect();
    });

    test('Can register a request handler and call it', () async {
      final connectionInfo = await SignClientHelpers.testConnectMethod(
        clientA,
        clientB,
      );

      final requestHandler = (request) async {
        expect(request, 'Hello');
        return 'Swag $request';
      };
      clientB.registerRequestHandler('eth', 'test_sign', requestHandler);

      try {
        final result = await clientA.request(
          RequestParams(
            topic: connectionInfo.session.topic,
            request: WcSessionRequestRequest(
              chainId: 'eth',
              method: 'test_sign',
              params: 'Hello',
            ),
          ),
        );

        expect(result, 'Swag Hello');
      } on JsonRpcError catch (e) {
        print(e);
        expect(false, true);
      }
    });

    test('Throws an error if you try to call a method that does not exist',
        () async {
      final connectionInfo = await SignClientHelpers.testConnectMethod(
        clientA,
        clientB,
      );

      try {
        final result = await clientA.request(
          RequestParams(
            topic: connectionInfo.session.topic,
            request: WcSessionRequestRequest(
              chainId: 'eth',
              method: 'test_sign',
              params: 'Hello',
            ),
          ),
        );
        // print(result);
      } on JsonRpcError catch (e) {
        print(e.message);
        expect(e.message, 'No handler found for method: eth:test_sign');
      }
    });
  });
}
