import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_connect/models/wc_method.dart';
import 'package:wallet_connect/utils/constants.dart';

part 'json_rpc_request.freezed.dart';
part 'json_rpc_request.g.dart';

@immutable
@freezed
class JsonRpcRequest with _$JsonRpcRequest {
  factory JsonRpcRequest({
    required int id,
    @Default(JSONRPC_VERSION) String jsonrpc,
    WCMethod? method,
    required List<dynamic>? params,
  }) = _JsonRpcRequest;

  factory JsonRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcRequestFromJson(json);
}
