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

    test('Can register an event handler and recieve events with it', () async {
      final connectionInfo = await SignClientHelpers.testConnectMethod(
        clientA,
        clientB,
      );
      final sessionTopic = connectionInfo.session.topic;

      clientB.onSessionEvent.subscribe((SessionEvent? session) {
        expect(session != null, true);
        expect(session!.topic, sessionTopic);
        expect(session.data, "Hello");
      });

      final requestHandler = (topic, request) async {
        expect(topic, sessionTopic);
        expect(request, 'Hello');

        // Events return no responses
      };
      clientB.registerEventHandler(
        chainId: 'eip155:1',
        event: 'kadena_transaction_updated',
        handler: requestHandler,
      );

      try {
        await clientA.emit(
          topic: connectionInfo.session.topic,
          chainId: 'eip155:1',
          event: SessionEventParams(
            name: 'kadena_transaction_updated',
            data: 'Hello',
          ),
        );

        // Events receive no responses
      } on JsonRpcError catch (e) {
        print(e);
        expect(false, true);
      }

      // Wait a second for the event to fire
      await Future.delayed(const Duration(milliseconds: 100));

      clientB.onSessionEvent.unsubscribeAll();
    });
  });
}
