import 'package:event/event.dart';

import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/core/store/i_store_user.dart';
import 'package:wallet_connect/models/apis/json_rpc_request.dart';

abstract class IJsonRpcHistory extends IStoreUser {
  abstract final Event<HistoryEvent> created;
  abstract final Event<HistoryEvent> updated;
  abstract final Event<HistoryEvent> deleted;
  abstract final Event sync;

  Future<void> init();
  bool has(int key);
  Future<void> set(
    String topic,
    JsonRpcRequest value, {
    String? chainId,
  });
  Future<void> resolve(Map<String, dynamic> response);
  JsonRpcRecord? get(int key);
  Future<void> delete(int key);
}
