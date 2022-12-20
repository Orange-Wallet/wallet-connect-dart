import 'package:wallet_connect_v2/apis/models/models.dart';

abstract class IStore<T> {
  abstract final Map<String, T> map;
  abstract final List<String> keys;
  abstract final List<T> values;
  abstract final String storagePrefix;

  Future<void> init();
  Future<void> set(String key, T value);
  dynamic get(String key);
  List<dynamic> getAll();
  Future<void> update(String key, T value);
  Future<void> delete(String key);
}
