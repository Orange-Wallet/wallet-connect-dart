import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_connect_v2/apis/core/core.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_models.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';

import 'shared/shared_test_utils.mocks.dart';

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

  group('Pairing API', () {
    late ICore coreA;
    late ICore coreB;

    setUp(() async {
      coreA = Core(TEST_RELAY_URL, TEST_PROJECT_ID, memoryStore: true);
      coreB = Core(TEST_RELAY_URL, TEST_PROJECT_ID, memoryStore: true);
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
      print(response.uri);
      print('${coreA.protocol}%3A${response.topic}@${coreA.version}');
      expect(
        response.uri.toString().startsWith(
              '${coreA.protocol}%3A${response.topic}@${coreA.version}',
            ),
        true,
      );
    });

    group('Pair', () {
      test("can pair via provided URI", () async {
        final CreateResponse response = await coreA.pairing.create();

        await coreB.pairing.pair(response.uri);

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

        await coreB.pairing.pair(response.uri, activatePairing: true);
        expect(coreA.pairing.getPairings()[0].active, false);
        expect(coreB.pairing.getPairings()[0].active, true);
      });
    });

    test("can activate pairing", () async {
      final CreateResponse response = await coreA.pairing.create();

      await coreB.pairing.pair(response.uri);
      PairingInfo? pairing = coreB.pairing.getStore().get(response.topic);

      expect(pairing != null, true);
      expect(pairing!.active, false);
      final int expiry = pairing.expiry;
      await coreB.pairing.activate(response.topic);
      PairingInfo? pairing2 = coreB.pairing.getStore().get(response.topic);
      expect(pairing2 != null, true);
      expect(pairing2!.active, true);
      expect(pairing2.expiry > expiry, true);
    });

    test("can update expiry", () async {
      final CreateResponse response = await coreA.pairing.create();
      final int mockExpiry = 1111111;

      coreA.pairing.updateExpiry(response.topic, mockExpiry);
      expect(coreA.pairing.getStore().get(response.topic)!.expiry, mockExpiry);
    });

    test("can update peer metadata", () async {
      final CreateResponse response = await coreA.pairing.create();
      PairingMetadata mock = PairingMetadata(
        'Mock',
        'Mock Metadata',
        'https://mockurl.com',
        [],
        null,
      );

      expect(
        coreA.pairing.getStore().get(response.topic)!.peerMetadata == null,
        true,
      );
      coreA.pairing.updateMetadata(response.topic, mock);
      expect(
        coreA.pairing.getStore().get(response.topic)!.peerMetadata!.name,
        mock.name,
      );
    });

    test("clients can ping each other", () async {
      final CreateResponse response = await coreA.pairing.create();
      bool gotPing = false;

      coreB.pairing.onPairingPing.subscribe((args) {
        gotPing = true;
      });

      await coreB.pairing.pair(response.uri);
      await coreA.pairing.ping(response.topic);
      await Future.delayed(Duration(milliseconds: 500));
      expect(gotPing, true);
    });
  });
}
