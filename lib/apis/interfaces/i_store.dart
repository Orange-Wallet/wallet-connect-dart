import 'package:wallet_connect_v2/apis/models/models.dart';

abstract class IStore {
  abstract final Map<String, dynamic> map;
  abstract final String context;
  abstract final List<String> keys;
  abstract final List<dynamic> values;
  abstract final String storagePrefix;

  Future<void> init();
  Future<void> set(String key, dynamic value);
  dynamic get(String key);
  List<dynamic> getAll();
  Future<void> update(String key, dynamic value);
  Future<void> delete(String key, ErrorResponse reason);
}
