import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_error.dart';
import 'package:wallet_connect/utils/constants.dart';

part 'json_rpc_error_response.freezed.dart';
part 'json_rpc_error_response.g.dart';

@immutable
@freezed
class JsonRpcErrorResponse with _$JsonRpcErrorResponse {
  factory JsonRpcErrorResponse({
    required int id,
    required JsonRpcError error,
    @Default(JSONRPC_VERSION) String jsonrpc,
  }) = _JsonRpcErrorResponse;

  factory JsonRpcErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcErrorResponseFromJson(json);
}
