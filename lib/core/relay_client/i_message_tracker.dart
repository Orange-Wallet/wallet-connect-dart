import 'package:wallet_connect/core/store/i_store_user.dart';

abstract class IMessageTracker extends IStoreUser {
  Future<void> init();
  Future<void> recordMessageEvent(String topic, String message);
  bool messageIsRecorded(String topic, String message);
  Future<void> deleteSubscriptionMessages(String topic);
}
