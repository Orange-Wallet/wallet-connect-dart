import 'package:json_annotation/json_annotation.dart';

part 'basic_errors.g.dart';

/// ERRORS

@JsonSerializable()
class Error {
  int code;
  String message;

  Error(this.code, this.message);

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}

class ErrorResponse {
  int id;
  Error error;

  ErrorResponse(
    this.id,
    this.error,
  );
}

class RpcOptions {
  int ttl;
  bool prompt;
  int tag;

  RpcOptions(
    this.ttl,
    this.prompt,
    this.tag,
  );
}
