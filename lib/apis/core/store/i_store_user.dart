import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/store/i_store.dart';

abstract class IStoreUser {
  abstract final ICore core;
  abstract final String storageKey;
  Future<void> restore();
  Future<void> persist();
}
