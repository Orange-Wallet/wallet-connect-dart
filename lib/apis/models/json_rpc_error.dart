import 'package:json_annotation/json_annotation.dart';

part 'json_rpc_error.g.dart';

@JsonSerializable()
class JsonRpcError {
  final int code;
  final String message;
  JsonRpcError(
    this.code,
    this.message,
  );

  factory JsonRpcError.serverError(String message) =>
      JsonRpcError(-32000, message);
  factory JsonRpcError.invalidParams(String message) =>
      JsonRpcError(-32602, message);
  factory JsonRpcError.invalidRequest(String message) =>
      JsonRpcError(-32600, message);
  factory JsonRpcError.parseError(String message) =>
      JsonRpcError(-32700, message);
  factory JsonRpcError.methodNotFound(String message) =>
      JsonRpcError(-32601, message);

  factory JsonRpcError.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcErrorFromJson(json);
  Map<String, dynamic> toJson() => _$JsonRpcErrorToJson(this);

  @override
  String toString() => 'JsonRpcError(code: $code, message: $message)';
}
