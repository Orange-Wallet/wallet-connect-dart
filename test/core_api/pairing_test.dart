import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2_dart/apis/core/core.dart';
import 'package:wallet_connect_v2_dart/apis/core/i_core.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_v2_dart/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_v2_dart/apis/models/basic_errors.dart';

import '../shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const uri =
      "wc:7f6e504bfad60b485450578e05678ed3e8e8c4751d3c6160be17160d63ec90f9@2?symKey=587d5484ce2a2a6ee3ba1962fdd7e8588e06200c46823bd18fbd67def96ad303&relay-protocol=irn";

  group('Pairing API', () {
    late ICore coreA;
    late ICore coreB;

    setUp(() async {
      coreA = Core(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
      );
      coreB = Core(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
      );
      await coreA.start();
      await coreB.start();
    });

    tearDown(() async {
      await coreA.relayClient.disconnect();
      await coreB.relayClient.disconnect();
    });

    test('Initializes', () async {
      expect(coreA.pairing.getPairings().length, 0);
      expect(coreB.pairing.getPairings().length, 0);
    });

    test('Create returns pairing topic and URI in expected format', () async {
      CreateResponse response = await coreA.pairing.create();
      expect(response.topic.length, 64);
      // print(response.uri);
      // print('${coreA.protocol}:${response.topic}@${coreA.version}');
      expect(
        response.uri.toString().startsWith(
              '${coreA.protocol}:${response.topic}@${coreA.version}',
            ),
        true,
      );
    });

    group('Pair', () {
      test("can pair via provided URI", () async {
        final CreateResponse response = await coreA.pairing.create();

        await coreB.pairing.pair(uri: response.uri);

        expect(coreA.pairing.getPairings().length, 1);
        expect(coreB.pairing.getPairings().length, 1);
        expect(
          coreA.pairing.getPairings()[0].topic,
          coreB.pairing.getPairings()[0].topic,
        );
        expect(coreA.pairing.getPairings()[0].active, false);
        expect(coreB.pairing.getPairings()[0].active, false);
      });

      test("can pair via provided URI", () async {
        final CreateResponse response = await coreA.pairing.create();

        await coreB.pairing.pair(uri: response.uri, activatePairing: true);
        expect(coreA.pairing.getPairings()[0].active, false);
        expect(coreB.pairing.getPairings()[0].active, true);
      });
    });

    test("can activate pairing", () async {
      final CreateResponse response = await coreA.pairing.create();

      await coreB.pairing.pair(uri: response.uri);
      PairingInfo? pairing = coreB.pairing.getStore().get(response.topic);

      expect(pairing != null, true);
      expect(pairing!.active, false);
      final int expiry = pairing.expiry;
      await coreB.pairing.activate(topic: response.topic);
      PairingInfo? pairing2 = coreB.pairing.getStore().get(response.topic);
      expect(pairing2 != null, true);
      expect(pairing2!.active, true);
      expect(pairing2.expiry > expiry, true);
    });

    test("can update expiry", () async {
      final CreateResponse response = await coreA.pairing.create();
      final int mockExpiry = 1111111;

      coreA.pairing.updateExpiry(topic: response.topic, expiry: mockExpiry);
      expect(coreA.pairing.getStore().get(response.topic)!.expiry, mockExpiry);
    });

    test("can update peer metadata", () async {
      final CreateResponse response = await coreA.pairing.create();
      PairingMetadata mock = PairingMetadata(
        'Mock',
        'Mock Metadata',
        'https://mockurl.com',
        [],
      );

      expect(
        coreA.pairing.getStore().get(response.topic)!.peerMetadata == null,
        true,
      );
      coreA.pairing.updateMetadata(topic: response.topic, metadata: mock);
      expect(
        coreA.pairing.getStore().get(response.topic)!.peerMetadata!.name,
        mock.name,
      );
    });

    test("clients can ping each other", () async {
      final CreateResponse response = await coreA.pairing.create();
      // await coreB.pairing.pair(uri: response.uri);
      bool gotPing = false;

      coreB.pairing.onPairingPing.subscribe((args) {
        gotPing = true;
      });

      print('swag 1');
      await coreB.pairing.pair(uri: response.uri, activatePairing: true);
      print('swag 2');
      await coreA.pairing.activate(topic: response.topic);
      print('swag 3');
      await coreA.pairing.ping(topic: response.topic);
      await Future.delayed(Duration(milliseconds: 500));
      expect(gotPing, true);
    });

    test("can disconnect from a known pairing", () async {
      final CreateResponse response = await coreA.pairing.create();
      expect(coreA.pairing.getStore().getAll().length, 1);
      expect(coreB.pairing.getStore().getAll().length, 0);
      await coreB.pairing.pair(uri: response.uri, activatePairing: true);
      expect(coreA.pairing.getStore().getAll().length, 1);
      expect(coreB.pairing.getStore().getAll().length, 1);
      bool hasDeletedA = false;
      bool hasDeletedB = false;

      coreA.pairing.onPairingDelete.subscribe((args) {
        expect(args != null, true);
        expect(args!.topic != null, true);
        expect(args.error == null, true);
        hasDeletedA = true;
      });
      coreB.pairing.onPairingDelete.subscribe((args) {
        expect(args != null, true);
        expect(args!.topic != null, true);
        expect(args.error == null, true);
        hasDeletedB = true;
      });

      await coreB.pairing.disconnect(topic: response.topic);
      await Future.delayed(Duration(milliseconds: 500));
      expect(hasDeletedA, true);
      expect(hasDeletedB, true);
      expect(coreA.pairing.getStore().getAll().length, 0);
      expect(coreB.pairing.getStore().getAll().length, 0);
    });

    group('Validations', () {
      setUp(() async {
        coreA = Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        );
        await coreA.start();
      });

      tearDown(() async {
        await coreA.relayClient.disconnect();
      });

      group('Pairing', () {
        test("throws when no empty/invalid uri is provided", () async {
          expect(
            () async => await coreA.pairing.pair(uri: Uri.parse('')),
            throwsA(
              predicate(
                (e) => e is Error && e.message == 'Invalid URI: Missing @',
              ),
            ),
          );
          expect(
            () async => await coreA.pairing.pair(uri: Uri.parse('wc:abc')),
            throwsA(
              predicate(
                (e) => e is Error && e.message == 'Invalid URI: Missing @',
              ),
            ),
          );
        });

        test("throws when required methods aren't contained in registered",
            () async {
          final String uriWithMethods =
              '$uri&methods=[wc_sessionPropose],[wc_authRequest,wc_authBatchRequest]';
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is Error &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_sessionPropose, wc_authRequest, wc_authBatchRequest.',
              ),
            ),
          );
          coreA.pairing.register(
            method: 'wc_sessionPropose',
            function: (s, r) => {},
            type: ProtocolType.Sign,
          );
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is Error &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_authRequest, wc_authBatchRequest.',
              ),
            ),
          );
          coreA.pairing.register(
            method: 'wc_authRequest',
            function: (s, r) => {},
            type: ProtocolType.Auth,
          );
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is Error &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_authBatchRequest.',
              ),
            ),
          );
        });

        test("succeeds when required methods are contained in registered",
            () async {
          final String uriWithMethods =
              '$uri&methods=[wc_sessionPropose],[wc_authRequest,wc_authBatchRequest]';
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is Error &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_sessionPropose, wc_authRequest, wc_authBatchRequest.',
              ),
            ),
          );
          coreA.pairing.register(
            method: 'wc_sessionPropose',
            function: (s, r) => {},
            type: ProtocolType.Sign,
          );
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is Error &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_authRequest, wc_authBatchRequest.',
              ),
            ),
          );
          coreA.pairing.register(
            method: 'wc_authRequest',
            function: (s, r) => {},
            type: ProtocolType.Auth,
          );
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is Error &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_authBatchRequest.',
              ),
            ),
          );
        });
      });

      group('Ping', () {
        test("throws when unused topic is provided", () async {
          expect(
            () async => await coreA.pairing.ping(topic: 'abc'),
            throwsA(
              predicate((e) =>
                  e is JsonRpcError &&
                  e.message ==
                      "No matching key. pairing topic doesn't exist: abc"),
            ),
          );
        });
      });

      group('Disconnect', () {
        test("throws when unused topic is provided", () async {
          expect(
            () async => await coreA.pairing.disconnect(topic: 'abc'),
            throwsA(
              predicate((e) =>
                  e is JsonRpcError &&
                  e.message ==
                      "No matching key. pairing topic doesn't exist: abc"),
            ),
          );
        });
      });

      // it("throws when invalid uri is provided", async () => {
      //   // @ts-expect-error - ignore TS error to test runtime validation
      //   await expect(coreA.pairing.pair({ uri: 123 })).rejects.toThrowError(
      //     "Missing or invalid. pair() uri: 123",
      //   );
      // });
    });
  });
}
