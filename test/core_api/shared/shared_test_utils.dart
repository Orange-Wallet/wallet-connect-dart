import 'package:mockito/annotations.dart';
import 'package:wallet_connect_v2_dart/apis/core/crypto/crypto.dart';
import 'package:wallet_connect_v2_dart/apis/core/crypto/crypto_utils.dart';
import 'package:wallet_connect_v2_dart/apis/core/key_chain/key_chain.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/message_tracker.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/topic_map.dart';

@GenerateMocks([
  KeyChain,
  CryptoUtils,
  Crypto,
  MessageTracker,
  TopicMap,
])
class SharedTestUtils {}
