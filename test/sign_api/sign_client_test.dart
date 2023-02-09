import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2_dart/apis/core/i_core.dart';
import 'package:wallet_connect_v2_dart/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/engine.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/i_engine.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/proposals.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/sessions.dart';
import 'package:wallet_connect_v2_dart/apis/utils/constants.dart';
import 'package:wallet_connect_v2_dart/wallet_connect_v2.dart';

import '../shared/shared_test_values.dart';
import 'utils/engine_constants.dart';
import 'utils/sign_client_constants.dart';
import 'sign_client_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<Future<IEngine> Function(ICore, PairingMetadata?)>
      signingApiCreators = [
    (ICore core, PairingMetadata? self) async =>
        await SignClient.createInstance(
          core,
          self: self,
        ),
    (ICore core, PairingMetadata? self) async {
      Proposals p = Proposals(core);
      Sessions s = Sessions(core);
      IEngine e = Engine(
        core,
        p,
        s,
        selfMetadata: self,
      );
      await core.start();
      await e.init();

      return e;
    }
  ];

  final List<String> contexts = ['SignClient', 'SignEngine'];

  for (int i = 0; i < signingApiCreators.length; i++) {
    signingEngineTests(
      context: contexts[i],
      engineCreator: signingApiCreators[i],
    );
  }
}

void signingEngineTests({
  required String context,
  required Function(ICore, PairingMetadata?) engineCreator,
}) {
  group(context, () {
    late IEngine clientA;
    late IEngine clientB;
    setUp(() async {
      clientA = await engineCreator(
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
        PairingMetadata(
          name: 'App A (Proposer, dapp)',
          description: 'Description of Proposer App run by client A',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
      clientB = await engineCreator(
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
        PairingMetadata(
          name: 'App B (Responder, Wallet)',
          description: 'Description of Proposer App run by client B',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
    });

    tearDown(() async {
      await clientA.core.relayClient.disconnect();
      await clientA.core.relayClient.disconnect();
    });

    // group('happy path', () {
    //   test('Initializes', () async {
    //     expect(clientA.core.pairing.getPairings().length, 0);
    //     expect(clientB.core.pairing.getPairings().length, 0);
    //   });

    //   test('connects, and reconnects', () async {
    //     final connectionInfo = await SignClientHelpers.testConnectPairApprove(
    //       clientA,
    //       clientB,
    //     );
    //     expect(
    //       clientA.pairings.getAll().length,
    //       clientB.pairings.getAll().length,
    //     );
    //     final connectionInfo2 = await SignClientHelpers.testConnectPairApprove(
    //       clientA,
    //       clientB,
    //       pairingTopic: connectionInfo.pairing.topic,
    //     );
    //   });

    //   test('connects, and reconnects with scan latency', () async {
    //     final connectionInfo = await SignClientHelpers.testConnectPairApprove(
    //       clientA,
    //       clientB,
    //       qrCodeScanLatencyMs: 1000,
    //     );
    //     expect(
    //       clientA.pairings.getAll().length,
    //       clientB.pairings.getAll().length,
    //     );
    //     final connectionInfo2 = await SignClientHelpers.testConnectPairApprove(
    //       clientA,
    //       clientB,
    //       pairingTopic: connectionInfo.pairing.topic,
    //       qrCodeScanLatencyMs: 1000,
    //     );
    //   });
    // });

    group('connect', () {
      test('invalid topic', () {
        expect(
          () async => await clientA.connect(
            requiredNamespaces: TEST_REQUIRED_NAMESPACES,
            pairingTopic: TEST_TOPIC_INVALID,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. pairing topic doesn\'t exist: abc',
            ),
          ),
        );
      });

      test('invalid required and optional namespaces', () {
        expect(
          () async => await clientA.connect(
            requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. connect() check requiredNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
            ),
          ),
        );
        expect(
          () async => await clientA.connect(
            requiredNamespaces: TEST_REQUIRED_NAMESPACES,
            optionalNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. connect() check optionalNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
            ),
          ),
        );
      });
    });

    group('pair', () {});

    group('approve', () {
      setUp(() async {
        await clientA.proposals.set(
          TEST_PROPOSAL_VALID_ID.toString(),
          TEST_PROPOSAL_VALID,
        );
        await clientA.proposals.set(
          TEST_PROPOSAL_EXPIRED_ID.toString(),
          TEST_PROPOSAL_EXPIRED,
        );
        await clientA.proposals.set(
          TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID.toString(),
          TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES,
        );
        await clientA.proposals.set(
          TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID.toString(),
          TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES,
        );
      });

      test('invalid proposal id', () async {
        expect(
          () async => await clientA.approve(
            id: TEST_APPROVE_ID_INVALID,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. proposal id doesn\'t exist: $TEST_APPROVE_ID_INVALID',
            ),
          ),
        );
        expect(
          () async => await clientA.approve(
            id: TEST_PROPOSAL_EXPIRED_ID,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Expired. proposal id: $TEST_PROPOSAL_EXPIRED_ID',
            ),
          ),
        );
        expect(
          clientA.proposals.has(
            TEST_PROPOSAL_EXPIRED_ID.toString(),
          ),
          false,
        );
      });

      test('invalid namespaces', () async {
        expect(
          () async => await clientA.approve(
            id: TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. approve() check requiredNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
            ),
          ),
        );
        expect(
          () async => await clientA.approve(
            id: TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. approve() check optionalNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
            ),
          ),
        );
        expect(
          () async => await clientA.approve(
            id: TEST_PROPOSAL_VALID_ID,
            namespaces: TEST_NAMESPACES_NONCONFORMING_KEY_1,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Non conforming namespaces. approve() namespaces keys don\'t satisfy requiredNamespaces',
            ),
          ),
        );
      });
    });

    group('reject', () {
      test('deletes the proposal', () async {
        await clientA.proposals.set(
          TEST_PROPOSAL_VALID_ID.toString(),
          TEST_PROPOSAL_VALID,
        );

        await clientA.reject(
          id: TEST_PROPOSAL_VALID_ID,
          reason: WCErrorResponse(code: -1, message: 'reason'),
        );

        expect(
          clientA.proposals.has(
            TEST_PROPOSAL_VALID_ID.toString(),
          ),
          false,
        );
      });

      test('invalid proposal id', () async {
        expect(
          () async => await clientA.reject(
            id: TEST_APPROVE_ID_INVALID,
            reason: WCErrorResponse(code: -1, message: 'reason'),
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. proposal id doesn\'t exist: $TEST_APPROVE_ID_INVALID',
            ),
          ),
        );
      });
    });

    group('update', () {
      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
      });

      test('works', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
          requiredNamespaces: {
            EVM_NAMESPACE: TEST_ETH_ARB_REQUIRED_NAMESPACE,
          },
        );

        await clientA.update(
          topic: connectionInfo.session.topic,
          namespaces: {EVM_NAMESPACE: TEST_ETH_ARB_NAMESPACE},
        );

        await Future.delayed(Duration(milliseconds: 100));

        // Check that the session was updated
        expect(
          clientA.sessions.has(connectionInfo.session.topic),
          true,
        );
        final updatedSessionA =
            clientA.sessions.get(connectionInfo.session.topic);
        expect(updatedSessionA!.namespaces.keys.length == 1, true);
        expect(updatedSessionA.namespaces.keys.first, EVM_NAMESPACE);
        expect(
          clientB.sessions.has(connectionInfo.session.topic),
          true,
        );
        final updatedSessionB =
            clientA.sessions.get(connectionInfo.session.topic);
        expect(updatedSessionB!.namespaces.keys.length == 1, true);
        expect(updatedSessionB.namespaces.keys.first, EVM_NAMESPACE);
      });

      test('invalid session topic', () async {
        expect(
          () async => await clientA.update(
            topic: TEST_SESSION_INVALID_TOPIC,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );
        expect(
          () async => await clientA.update(
            topic: TEST_SESSION_EXPIRED_TOPIC,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
            ),
          ),
        );
        await Future.delayed(Duration(milliseconds: 100));
        expect(
          clientA.sessions.has(
            TEST_SESSION_EXPIRED_TOPIC,
          ),
          false,
        );
      });

      test('invalid namespaces', () async {
        expect(
          () async => await clientA.update(
            topic: TEST_SESSION_VALID_TOPIC,
            namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported accounts. update() namespace, account swag should conform to "namespace:chainId:address" format',
            ),
          ),
        );
        expect(
          () async => await clientA.update(
            topic: TEST_SESSION_VALID_TOPIC,
            namespaces: TEST_NAMESPACES_NONCONFORMING_CHAINS,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Non conforming namespaces. update() namespaces accounts don\'t satisfy requiredNamespaces chains for eip155',
            ),
          ),
        );
      });
    });

    group('extend', () {
      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
      });

      test('works', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );

        final startingExpiryA =
            clientA.sessions.get(connectionInfo.session.topic)!.expiry;
        final startingExpiryB =
            clientB.sessions.get(connectionInfo.session.topic)!.expiry;
        expect(clientA.core.expirer.has(connectionInfo.session.topic), true);
        expect(clientB.core.expirer.has(connectionInfo.session.topic), true);

        final offset = 100;
        await Future.delayed(Duration(milliseconds: offset));

        await clientA.extend(
          topic: connectionInfo.session.topic,
        );

        await Future.delayed(Duration(milliseconds: 100));

        final endingExpiryA =
            clientA.sessions.get(connectionInfo.session.topic)!.expiry;
        final endingExpiryB =
            clientB.sessions.get(connectionInfo.session.topic)!.expiry;

        expect(
          endingExpiryA >= startingExpiryA,
          true,
        );
        expect(
          endingExpiryB >= startingExpiryB,
          true,
        );
        expect(
          clientA.core.expirer.get(connectionInfo.session.topic) ==
              endingExpiryA,
          true,
        );
        expect(
          clientB.core.expirer.get(connectionInfo.session.topic) ==
              endingExpiryB,
          true,
        );
      });

      test('invalid session topic', () async {
        expect(
          () async => await clientA.extend(
            topic: TEST_SESSION_INVALID_TOPIC,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );
        expect(
          () async => await clientA.extend(
            topic: TEST_SESSION_EXPIRED_TOPIC,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
            ),
          ),
        );
        await Future.delayed(Duration(milliseconds: 100));
        expect(
          clientA.sessions.has(
            TEST_SESSION_EXPIRED_TOPIC,
          ),
          false,
        );
      });
    });

    group('request and handler', () {
      test('Can register a request handler and call it', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionTopic = connectionInfo.session.topic;

        clientB.onSessionRequest.subscribe((SessionRequest? session) {
          expect(session != null, true);
          expect(session!.topic, sessionTopic);
          expect(session.params, "Hello");
        });

        final requestHandler = (topic, request) async {
          expect(request, 'Hello');
          return {'response': '$topic: Swag $request'};
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

          expect(result, {'response': '$sessionTopic: Swag Hello'});
        } on JsonRpcError catch (e) {
          print(e);
          expect(false, true);
        }

        // Wait a second for the event to fire
        await Future.delayed(const Duration(milliseconds: 100));

        clientB.onSessionRequest.unsubscribeAll();
      });

      test('Throws an error if you try to call a method that does not exist',
          () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
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
          // print(e.message);
          expect(
            e.message,
            'No handler found for chainId:method -> eip155:255:test_sign',
          );
        }
      });
    });

    group('emit and handler', () {
      test('register an event handler and recieve events with it', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
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

    group('ping', () {});

    group("disconnect", () {
      group("pairing", () {
        test("deletes the pairing on disconnect", () async {
          final connectionInfo = await SignClientHelpers.testConnectPairApprove(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          final reason = Errors.getSdkError("USER_DISCONNECTED");
          await clientA.disconnect(
            topic: pairingATopic,
            reason: WCErrorResponse(
              code: reason.code,
              message: reason.message,
            ),
          );
          expect(
            clientA.pairings.get(pairingATopic),
            null,
          );
          await clientA.core.relayClient.disconnect();
          await clientA.core.relayClient.disconnect();
          final promise = clientA.ping(
            topic: pairingATopic,
          );
          expect(
            promise,
            throwsA(
              isA<WCError>().having(
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
          final connectionInfo = await SignClientHelpers.testConnectPairApprove(
            clientA,
            clientB,
          );
          final sessionATopic = connectionInfo.pairing.topic;
          final reason = Errors.getSdkError("USER_DISCONNECTED");
          await clientA.disconnect(
            topic: sessionATopic,
            reason: WCErrorResponse(
              code: reason.code,
              message: reason.message,
            ),
          );
          await clientA.core.relayClient.disconnect();
          await clientA.core.relayClient.disconnect();
          expect(clientA.sessions.get(sessionATopic), null);
        });
      });
    });

    group('ping', () {
      test("throws if the topic is not a known pairing or session topic",
          () async {
        final fakeTopic = "nonsense";
        final promise = clientA.ping(
          topic: fakeTopic,
        );
        expect(
          promise,
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              "No matching key. session or pairing topic doesn't exist: $fakeTopic",
            ),
          ),
        );
      });

      group("with existing pairing", () {
        test("A pings B", () async {
          final connectionInfo = await SignClientHelpers.testConnectPairApprove(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientA.ping(topic: pairingATopic);
        });
        test("B pings A", () async {
          final connectionInfo = await SignClientHelpers.testConnectPairApprove(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientB.ping(topic: pairingATopic);
        });
      });
    });

    group('session', () {
      group("with existing session", () {
        test("A pings B", () async {
          final connectionInfo = await SignClientHelpers.testConnectPairApprove(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientA.ping(topic: pairingATopic);
        });
        test("B pings A", () async {
          final connectionInfo = await SignClientHelpers.testConnectPairApprove(
            clientA,
            clientB,
          );
          final pairingATopic = connectionInfo.pairing.topic;
          await clientB.ping(topic: pairingATopic);
        });
      });
    });

    group("update", () {
      test("session namespaces state with provided namespaces", () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionATopic = connectionInfo.session.topic;
        final namespacesBefore =
            clientA.sessions.get(sessionATopic)!.namespaces;
        final namespacesAfter = {
          ...namespacesBefore,
          'eip9001': Namespace(
            accounts: ["eip9001:1:0x000000000000000000000000000000000000dead"],
            methods: ["eth_sendTransaction"],
            events: ["accountsChanged"],
          ),
        };
        print(clientA.sessions.get(sessionATopic)!.requiredNamespaces);
        print(namespacesAfter);

        await clientA.update(
          topic: sessionATopic,
          namespaces: namespacesAfter,
        );
        final resultA = clientA.sessions.get(sessionATopic)!.namespaces;
        final resultB = clientB.sessions.get(sessionATopic)!.namespaces;
        expect(resultA, equals(namespacesAfter));
        expect(resultB, equals(namespacesAfter));
      });
    });

    group('find', () {});

    group('pairings', () {});
  });
}
