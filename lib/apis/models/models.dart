/// ERRORS

class Error {
  int code;
  String message;

  Error(this.code, this.message);
}

class ErrorResponse {
  int id;
  Error error;

  ErrorResponse(
    this.id,
    this.error,
  );
}
