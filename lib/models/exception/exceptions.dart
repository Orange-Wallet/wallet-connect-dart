class HmacException implements Exception {
  final String message = "Hmac from payload and calculated hmac doesn't match.";

  String toString() {
    return "HandshakeException: $message";
  }
}

class InvalidJsonRpcParamsException implements Exception {
  final int requestId;
  final String message;

  InvalidJsonRpcParamsException(this.requestId)
      : this.message = 'Invalid JSON RPC Request.';

  String toString() {
    return "InvalidJsonRpcParamsException: $message";
  }
}

class InvalidSessionException implements Exception {
  final String message = "WCSession object doesn't have correct data.";

  String toString() {
    return "HandshakeException: $message";
  }
}

class HandshakeException implements Exception {
  final String message =
      "handshakeId must be greater than 0 on session approve/reject.";

  String toString() {
    return "HandshakeException: $message";
  }
}
