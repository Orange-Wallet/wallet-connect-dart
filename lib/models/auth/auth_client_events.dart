import 'package:event/event.dart';

import 'package:wallet_connect/models/auth/auth_client_models.dart';
import 'package:wallet_connect/models/basic_models.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_error.dart';

class AuthRequest extends EventArgs {
  final int id;
  final String topic;
  final AuthPayloadParams payloadParams;
  final ConnectionMetadata requester;

  AuthRequest({
    required this.id,
    required this.topic,
    required this.payloadParams,
    required this.requester
  });
}

class AuthResponse extends EventArgs {
  final int id;
  final String topic;
  final Cacao? result;
  final WalletConnectError? error;
  final JsonRpcError? jsonRpcError;

  AuthResponse({
    required this.id,
    required this.topic,
    this.result,
    this.error,
    this.jsonRpcError
  });
}
