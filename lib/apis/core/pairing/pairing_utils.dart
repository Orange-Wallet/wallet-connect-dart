import 'dart:math';

import 'package:wallet_connect_v2/apis/models/json_rpc_error.dart';

class PairingUtils {
  static int payloadId() {
    int date = DateTime.now().millisecondsSinceEpoch;
    int extra = Random().nextInt(1000) * 1000;
    return date + extra;
  }

  static Map<String, dynamic> formatJsonRpcRequest(
    String method,
    Map<String, dynamic> params,
  ) {
    return {
      'id': payloadId(),
      'jsonrpc': '2.0',
      'method': method,
      'params': params,
    };
  }

  static Map<String, dynamic> formatJsonRpcResponse<T>(
    int id,
    T result,
  ) {
    return {
      'id': id,
      'jsonrpc': '2.0',
      'result': result,
    };
  }

  static Map<String, dynamic> formatJsonRpcError(int id, JsonRpcError error) {
    return {
      'id': id,
      'jsonrpc': '2.0',
      'error': error.toJson(),
    };
  }
}
