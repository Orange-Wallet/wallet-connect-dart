import 'dart:async';

import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/models/json_rpc_response.dart';
import 'package:wallet_connect_v2_dart/apis/models/basic_errors.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/session_models.dart';

class UriParameters {
  final String protocol;
  final int version;
  final String topic;
  final String symKey;
  final Relay relay;

  UriParameters(
    this.protocol,
    this.version,
    this.topic,
    this.symKey,
    this.relay,
  );
}

class ConnectParams {
  final Map<String, RequiredNamespace> requiredNamespaces;
  final String? pairingTopic;
  final List<Relay>? relays;

  ConnectParams({
    required this.requiredNamespaces,
    this.pairingTopic,
    this.relays,
  });
}

class ConnectResponse {
  final Completer session;
  final Uri? uri;

  ConnectResponse({
    required this.session,
    this.uri,
  });
}

class PairParams {
  final Uri uri;

  PairParams({
    required this.uri,
  });
}

class ApproveParams {
  final int id;
  final Map<String, Namespace> namespaces;
  final String? relayProtocol;

  ApproveParams({
    required this.id,
    required this.namespaces,
    this.relayProtocol,
  });
}

class ApproveResponse {
  final String topic;
  final SessionData session;

  ApproveResponse({
    required this.topic,
    required this.session,
  });
}

class RejectParams {
  final int id;
  final String reason;

  RejectParams({
    required this.id,
    required this.reason,
  });
}

class UpdateParams {
  final String topic;
  final Map<String, Namespace> namespaces;

  UpdateParams({
    required this.topic,
    required this.namespaces,
  });
}

class ExtendParams {
  final String topic;

  ExtendParams({
    required this.topic,
  });
}

class RequestParams {
  final String topic;
  final WcSessionRequestRequest request;

  RequestParams({
    required this.topic,
    required this.request,
  });
}

class RespondParams {
  final String topic;
  final JsonRpcResponse response;

  RespondParams({
    required this.topic,
    required this.response,
  });
}

class EmitEvent {
  String name;
  dynamic data;

  EmitEvent({
    required this.name,
    required this.data,
  });
}

class EmitParams {
  final String topic;
  final WcSessionEventRequest event;
  final String chainId;

  EmitParams({
    required this.topic,
    required this.event,
    required this.chainId,
  });
}

class PingParams {
  final String topic;

  PingParams({
    required this.topic,
  });
}

class DisconnectParams {
  final String topic;
  final ErrorResponse reason;

  DisconnectParams({
    required this.topic,
    required this.reason,
  });
}

class FindParams {
  final Map<String, RequiredNamespace> requiredNamespaces;

  FindParams({
    required this.requiredNamespaces,
  });
}
