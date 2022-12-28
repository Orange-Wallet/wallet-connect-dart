import 'package:mockito/annotations.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/key_chain/key_chain.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/message_tracker.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/topic_map.dart';
import 'package:wallet_connect_v2/apis/core/store/get_storage_store.dart';
import 'package:wallet_connect_v2/apis/core/store/store.dart';

@GenerateMocks([
  KeyChain,
  CryptoUtils,
  Crypto,
  Store,
  MessageTracker,
  TopicMap,
])
class SharedTestUtils {}