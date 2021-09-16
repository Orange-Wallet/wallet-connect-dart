class HmacException implements Exception {}

class InvalidJsonRpcParamsException implements Exception {
  final int requestId;
  final String message;

  InvalidJsonRpcParamsException(this.requestId)
      : this.message = 'Invalid JSON RPC Request';
}

class InvalidSessionException implements Exception {}
