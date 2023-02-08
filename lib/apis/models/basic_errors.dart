import 'package:json_annotation/json_annotation.dart';

part 'basic_errors.g.dart';

/// ERRORS

@JsonSerializable()
class Error {
  int code;
  String message;

  Error({
    required this.code,
    required this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}

@JsonSerializable()
class ErrorResponse extends Error {
  String? data;

  ErrorResponse({
    required super.code,
    required super.message,
    this.data,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

class RpcOptions {
  final int ttl;
  final bool prompt;
  final int tag;

  const RpcOptions(
    this.ttl,
    this.prompt,
    this.tag,
  );
}
