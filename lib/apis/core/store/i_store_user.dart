import 'package:wallet_connect_v2_dart/apis/core/i_core.dart';

abstract class IStoreUser {
  abstract final ICore core;
  abstract final String storageKey;
  Future<void> restore();
  Future<void> persist();
}
