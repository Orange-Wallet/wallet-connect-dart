import 'package:freezed_annotation/freezed_annotation.dart';

part 'json_rpc_error.freezed.dart';
part 'json_rpc_error.g.dart';

@immutable
@freezed
class JsonRpcError with _$JsonRpcError {
  const JsonRpcError._();

  const factory JsonRpcError(int code, String message) = RpcError;

  const factory JsonRpcError.serverError(
    String message, {
    @Default(-32000) int code,
  }) = ServerError;

  const factory JsonRpcError.invalidParams(
    String message, {
    @Default(-32602) int code,
  }) = InvalidParams;

  const factory JsonRpcError.invalidRequest(
    String message, {
    @Default(-32600) int code,
  }) = InvalidRequest;

  const factory JsonRpcError.parseError(
    String message, {
    @Default(-32700) int code,
  }) = ParseError;

  const factory JsonRpcError.methodNotFound(
    String message, {
    @Default(-32601) int code,
  }) = MethodNotFound;

  factory JsonRpcError.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcErrorFromJson(json);
}
