import 'package:flutter_test/flutter_test.dart';
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

    test('Initializes', () async {
      expect(clientA.core.pairing.getPairings().length, 0);
      expect(clientB.core.pairing.getPairings().length, 0);
    });

    test('connects with new pairing', () async {
      final connectionInfo = await SignClientHelpers.testConnectMethod(
        clientA,
        clientB,
      );
    });

    test('connect with old pairing', () async {
      final connectionInfo = await SignClientHelpers.testConnectMethod(
        clientA,
        clientB,
      );
      expect(
        clientA.pairings.getAll().length,
        clientB.pairings.getAll().length,
      );
      final connectionInfo2 = await SignClientHelpers.testConnectMethod(
        clientA,
        clientB,
        pairingTopic: connectionInfo.pairing.topic,
      );
    });

    group("disconnect", () {
      group("pairing", () {
        test("deletes the pairing on disconnect", () async {
          final connectionInfo = await SignClientHelpers.testConnectMethod(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          final reason = Errors.getSdkError("USER_DISCONNECTED");
          await clientA.disconnect(
            DisconnectParams(
              topic: pairingATopic,
              reason: ErrorResponse(0, reason),
            ),
          );
          expect(
            clientA.pairings.get(pairingATopic),
            null,
          );
          await clientA.core.relayClient.disconnect();
          await clientA.core.relayClient.disconnect();
          final promise = clientA.ping(
            PingParams(
              topic: pairingATopic,
            ),
          );
          expect(
            promise,
            throwsA(
              isA<Error>().having(
                (e) => e.message,
                'message',
                "No matching key. session or pairing topic doesn't exist: $pairingATopic",
              ),
            ),
          );
        });
      });

      group("session", () {
        test("deletes the session on disconnect", () async {
          final connectionInfo = await SignClientHelpers.testConnectMethod(
            clientA,
            clientB,
          );
          final sessionATopic = connectionInfo.pairing.topic;
          final reason = Errors.getSdkError("USER_DISCONNECTED");
          await clientA.disconnect(
            DisconnectParams(
              topic: sessionATopic,
              reason: ErrorResponse(0, reason),
            ),
          );
          await clientA.core.relayClient.disconnect();
          await clientA.core.relayClient.disconnect();
          expect(clientA.engine.sessions.get(sessionATopic), null);
        });
      });
    });

    group('ping', () {
      test("throws if the topic is not a known pairing or session topic",
          () async {
        final fakeTopic = "nonsense";
        final promise = clientA.ping(
          PingParams(
            topic: fakeTopic,
          ),
        );
        expect(
          promise,
          throwsA(
            isA<Error>().having(
              (e) => e.message,
              'message',
              "No matching key. session or pairing topic doesn't exist: $fakeTopic",
            ),
          ),
        );
      });

      group("with existing pairing", () {
        test("A pings B", () async {
          final connectionInfo = await SignClientHelpers.testConnectMethod(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientA.ping(PingParams(topic: pairingATopic));
        });
        test("B pings A", () async {
          final connectionInfo = await SignClientHelpers.testConnectMethod(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientB.ping(PingParams(topic: pairingATopic));
        });
      });
    });

    group('session', () {
      group("with existing session", () {
        test("A pings B", () async {
          final connectionInfo = await SignClientHelpers.testConnectMethod(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientA.ping(PingParams(topic: pairingATopic));
        });
        test("B pings A", () async {
          final connectionInfo = await SignClientHelpers.testConnectMethod(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientB.ping(PingParams(topic: pairingATopic));
        });
      });
    });

    group("update", () {
      test("updates session namespaces state with provided namespaces",
          () async {
        final connectionInfo = await SignClientHelpers.testConnectMethod(
          clientA,
          clientB,
        );
        final sessionATopic = connectionInfo.session.topic;
        final namespacesBefore =
            clientA.engine.sessions.get(sessionATopic)!.namespaces;
        final namespacesAfter = {
          ...namespacesBefore,
          'eip9001': Namespace(
            accounts: ["eip9001:1:0x000000000000000000000000000000000000dead"],
            methods: ["eth_sendTransaction"],
            events: ["accountsChanged"],
          ),
        };

        await clientA.update(
          UpdateParams(
            topic: sessionATopic,
            namespaces: WcSessionUpdateRequest(
              namespaces: namespacesAfter,
            ),
          ),
        );
        final resultA = clientA.engine.sessions.get(sessionATopic)!.namespaces;
        final resultB = clientB.engine.sessions.get(sessionATopic)!.namespaces;
        expect(resultA, equals(namespacesAfter));
        expect(resultB, equals(namespacesAfter));
      });
    });
  });
}
