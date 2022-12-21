import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/i_message_tracker.dart';
import 'package:wallet_connect_v2/apis/core/store/i_store_user.dart';

class MessageTracker implements IMessageTracker {
  static const MESSAGE_TRACKER_CONTEXT = 'MESSAGE_TRACKER';
  static const VERSION = '1.0';

  @override
  String get storageKey => '$VERSION//$MESSAGE_TRACKER_CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;
  Map<String, Map<String, String>> messageRecords = {};

  MessageTracker(this.core);

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.storage.init();
    await restore();

    _initialized = true;
  }

  Future<void> recordMessageEvent(String topic, String message) async {
    final String hash = core.crypto.getUtils().hashMessage(message);
    if (!messageRecords.containsKey(topic)) {
      messageRecords[topic] = {};
    }
    messageRecords[topic]![hash] = message;
    await persist();
  }

  bool messageIsRecorded(String topic, String message) {
    final String hash = core.crypto.getUtils().hashMessage(message);
    return messageRecords.containsKey(topic) &&
        messageRecords[topic]!.containsKey(hash);
  }

  Future<void> deleteSubscriptionMessages(String topic) async {
    messageRecords.remove(topic);
    await persist();
  }

  @override
  Future<void> persist() async {
    await core.storage.set(storageKey, messageRecords);
  }

  @override
  Future<void> restore() async {
    messageRecords = core.storage.get(storageKey);
  }
}
