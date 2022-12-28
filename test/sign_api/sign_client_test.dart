import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2/apis/core/core.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/models/models.dart';
import 'package:wallet_connect_v2/apis/signing_api/i_sign_client.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/signing_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/sign_client.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';

import 'sign_client_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const TEST_PUB_KEY =
      '9088c381b2022c6311d9b4738e221029ff4b8f3c13860a795c960eac043e7d28';
  const TEST_PRIV_KEY =
      'f24230adbb096e81f4a2a06450c206cafaf49dc6a60daf25d09e05c011e47ed2';
  const TEST_TOPIC = 'abc123';
  const TEST_MESSAGE = 'swagmaster';
  const TEST_RELAY_URL = 'ws://0.0.0.0:5555';
  const TEST_PROJECT_ID = '7e984f90b95f0236d3c12d791537f233';

  group('Signing API', () {
    late ISignClient clientA;
    late ISignClient clientB;

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
              pairingATopic,
              ErrorResponse(0, reason),
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
              pairingATopic,
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
              sessionATopic,
              ErrorResponse(0, reason),
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
            fakeTopic,
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
          await clientA.ping(PingParams(pairingATopic));
        });
        test("B pings A", () async {
          final connectionInfo = await SignClientHelpers.testConnectMethod(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientB.ping(PingParams(pairingATopic));
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
          await clientA.ping(PingParams(pairingATopic));
        });
        test("B pings A", () async {
          final connectionInfo = await SignClientHelpers.testConnectMethod(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientB.ping(PingParams(pairingATopic));
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
              ["eip9001:1:0x000000000000000000000000000000000000dead"],
              ["eth_sendTransaction"],
              ["accountsChanged"],
              []),
        };

        final updateResult = await clientA.update(
          UpdateParams(
            sessionATopic,
            WcSessionUpdateRequest(namespacesAfter),
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
