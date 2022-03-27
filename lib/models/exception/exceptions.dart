class HmacException implements Exception {
  final String message = "Hmac from payload and calculated hmac doesn't match.";

  @override
  String toString() {
    return "HandshakeException: $message";
  }
}

class InvalidJsonRpcParamsException implements Exception {
  final int requestId;
  final String message;

  InvalidJsonRpcParamsException(this.requestId)
      : message = 'Invalid JSON RPC Request.';

  @override
  String toString() {
    return "InvalidJsonRpcParamsException: $message";
  }
}

class InvalidSessionException implements Exception {
  final String message = "WCSession object doesn't have correct data.";

  @override
  String toString() {
    return "HandshakeException: $message";
  }
}

class HandshakeException implements Exception {
  final String message =
      "handshakeId must be greater than 0 on session approve/reject.";

  @override
  String toString() {
    return "HandshakeException: $message";
  }
}
