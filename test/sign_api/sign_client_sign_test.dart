import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2_dart/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_v2_dart/wallet_connect_v2.dart';

import '../shared/shared_test_values.dart';
import 'sign_client_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Signing API', () {
    late SignClient clientA;
    late SignClient clientB;

    setUp(() async {
      clientA = await SignClient.createInstance(
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
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
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
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
        return {'response': 'Swag $request'};
      };
      clientB.registerRequestHandler(
        chainId: 'eip155:1',
        method: 'eth_signTransaction',
        handler: requestHandler,
      );

      try {
        final result = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: 'eip155:1',
          request: SessionRequestParams(
            method: 'eth_signTransaction',
            params: 'Hello',
          ),
        );

        expect(result, {'response': 'Swag Hello'});
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
          topic: connectionInfo.session.topic,
          chainId: 'eip155:255',
          request: SessionRequestParams(
            method: 'test_sign',
            params: 'Hello',
          ),
        );
        // print(result);
      } on JsonRpcError catch (e) {
        print(e.message);
        expect(
          e.message,
          'No handler found for chainId:method -> eip155:255:test_sign',
        );
      }
    });
  });
}
