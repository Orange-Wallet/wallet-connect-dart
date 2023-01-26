import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/generic_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/session_models.dart';

part 'json_rpc_models.g.dart';

@JsonSerializable()
class WcPairingDeleteRequest {
  final int code;
  final String message;

  WcPairingDeleteRequest({required this.code, required this.message});

  factory WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcPairingDeleteRequestToJson(this);
}

@JsonSerializable()
class WcPairingPingRequest {
  final Map<String, dynamic> data;

  WcPairingPingRequest({required this.data});

  factory WcPairingPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingPingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcPairingPingRequestToJson(this);
}

@JsonSerializable()
class WcSessionProposeRequest {
  final List<Relay> relays;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final ConnectionMetadata proposer;

  WcSessionProposeRequest({
    required this.relays,
    required this.requiredNamespaces,
    required this.proposer,
  });

  factory WcSessionProposeRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionProposeRequestToJson(this);
}

@JsonSerializable()
class WcSessionProposeResponse {
  Relay relay;
  String responderPublicKey;

  WcSessionProposeResponse({
    required this.relay,
    required this.responderPublicKey,
  });

  factory WcSessionProposeResponse.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionProposeResponseToJson(this);
}

@JsonSerializable()
class WcSessionSettleRequest {
  final int id;
  final Relay relay;
  final Map<String, Namespace> namespaces;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final int expiry;
  final ConnectionMetadata controller;

  WcSessionSettleRequest({
    required this.id,
    required this.relay,
    required this.namespaces,
    required this.requiredNamespaces,
    required this.expiry,
    required this.controller,
  });

  factory WcSessionSettleRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionSettleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionSettleRequestToJson(this);
}

@JsonSerializable()
class WcSessionUpdateRequest {
  final Map<String, Namespace> namespaces;

  WcSessionUpdateRequest({required this.namespaces});

  factory WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionUpdateRequestToJson(this);
}

@JsonSerializable()
class WcSessionExtendRequest {
  final Map<String, dynamic> data;

  WcSessionExtendRequest({required this.data});

  factory WcSessionExtendRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionExtendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionExtendRequestToJson(this);
}

@JsonSerializable()
class WcSessionDeleteRequest {
  final int code;
  final String message;

  WcSessionDeleteRequest({required this.code, required this.message});

  factory WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionDeleteRequestToJson(this);
}

@JsonSerializable()
class WcSessionPingRequest {
  final Map<String, dynamic> data;

  WcSessionPingRequest({required this.data});

  factory WcSessionPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionPingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionPingRequestToJson(this);
}

@JsonSerializable()
class WcSessionRequestRequest {
  final String chainId;
  final SessionRequestParams request;

  WcSessionRequestRequest({
    required this.chainId,
    required this.request,
  });

  factory WcSessionRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionRequestRequestToJson(this);
}

@JsonSerializable()
class SessionRequestParams {
  final String method;
  final dynamic params;

  SessionRequestParams({
    required this.method,
    required this.params,
  });

  factory SessionRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionRequestParamsToJson(this);
}

@JsonSerializable()
class WcSessionEventRequest {
  final String name;
  final dynamic data;
  final String chainId;

  WcSessionEventRequest({
    required this.name,
    required this.data,
    required this.chainId,
  });

  factory WcSessionEventRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionEventRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionEventRequestToJson(this);
}
