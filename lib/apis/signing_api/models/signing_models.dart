import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/models/json_rpc_response.dart';
import 'package:wallet_connect_v2/apis/models/models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/session_models.dart';

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
  final List<Relay> relays;

  ConnectParams(
    this.requiredNamespaces,
    this.pairingTopic,
    this.relays,
  );
}

class ConnectResponse {
  final Uri? uri;

  ConnectResponse({
    this.uri,
  });
}

class PairParams {
  final Uri uri;

  PairParams(this.uri);
}

class ApproveParams {
  final int id;
  final Map<String, Namespace> namespaces;
  final String? relayProtocol;

  ApproveParams(
    this.id,
    this.namespaces, {
    this.relayProtocol,
  });
}

class ApproveResponse {
  final String topic;
  // final Completer acknowledged;

  ApproveResponse(
    this.topic,
    // this.acknowledged,
  );
}

class RejectParams {
  final int id;
  final ErrorResponse reason;

  RejectParams(
    this.id,
    this.reason,
  );
}

class UpdateParams {
  final String topic;
  final Map<String, Namespace> namespaces;

  UpdateParams(
    this.topic,
    this.namespaces,
  );
}

class ExtendParams {
  final String topic;

  ExtendParams(
    this.topic,
  );
}

class RequestParams {
  final String topic;
  final WcSessionRequestRequest request;
  final String chainId;

  RequestParams(
    this.topic,
    this.request,
    this.chainId,
  );
}

class RespondParams {
  final String topic;
  final JsonRpcResponse response;

  RespondParams(
    this.topic,
    this.response,
  );
}

class EmitEvent {
  String name;
  dynamic data;

  EmitEvent(this.name, this.data);
}

class EmitParams {
  final String topic;
  final WcSessionEventRequest event;
  final String chainId;

  EmitParams(
    this.topic,
    this.event,
    this.chainId,
  );
}

class PingParams {
  final String topic;

  PingParams(this.topic);
}

class DisconnectParams {
  final String topic;
  final ErrorResponse reason;

  DisconnectParams(
    this.topic,
    this.reason,
  );
}

class FindParams {
  final Map<String, RequiredNamespace> requiredNamespaces;

  FindParams(this.requiredNamespaces);
}
