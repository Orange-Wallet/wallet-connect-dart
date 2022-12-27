import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/generic_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/session_models.dart';

part 'json_rpc_models.g.dart';

@JsonSerializable()
class WcPairingDeleteRequest {
  final int code;
  final String message;

  WcPairingDeleteRequest(this.code, this.message);

  factory WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcPairingDeleteRequestToJson(this);
}

@JsonSerializable()
class WcPairingPingRequest {
  final Map<String, dynamic> data;

  WcPairingPingRequest(this.data);

  factory WcPairingPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingPingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcPairingPingRequestToJson(this);
}

@JsonSerializable()
class WcSessionProposeRequest {
  final int id;
  final List<Relay> relays;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final ConnectionMetadata proposer;

  WcSessionProposeRequest(
    this.id,
    this.relays,
    this.requiredNamespaces,
    this.proposer,
  );

  factory WcSessionProposeRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionProposeRequestToJson(this);
}

@JsonSerializable()
class WcSessionSettleRequest {
  final Relay relay;
  final Map<String, Namespace> namespaces;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final int expiry;
  final ConnectionMetadata controller;

  WcSessionSettleRequest(
    this.relay,
    this.namespaces,
    this.requiredNamespaces,
    this.expiry,
    this.controller,
  );

  factory WcSessionSettleRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionSettleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionSettleRequestToJson(this);
}

@JsonSerializable()
class WcSessionUpdateRequest {
  final Map<String, Namespace> namespaces;

  WcSessionUpdateRequest(this.namespaces);

  factory WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionUpdateRequestToJson(this);
}

@JsonSerializable()
class WcSessionExtendRequest {
  final Map<String, dynamic> data;

  WcSessionExtendRequest(this.data);

  factory WcSessionExtendRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionExtendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionExtendRequestToJson(this);
}

@JsonSerializable()
class WcSessionDeleteRequest {
  final int code;
  final String message;

  WcSessionDeleteRequest(this.code, this.message);

  factory WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionDeleteRequestToJson(this);
}

@JsonSerializable()
class WcSessionPingRequest {
  final Map<String, dynamic> data;

  WcSessionPingRequest(this.data);

  factory WcSessionPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionPingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionPingRequestToJson(this);
}

@JsonSerializable()
class WcSessionRequestRequest {
  final String method;
  final dynamic params;
  final String chainId;

  WcSessionRequestRequest(
    this.method,
    this.params,
    this.chainId,
  );

  factory WcSessionRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionRequestRequestToJson(this);
}

@JsonSerializable()
class WcSessionEventRequest {
  final String name;
  final dynamic data;
  final String chainId;

  WcSessionEventRequest(
    this.name,
    this.data,
    this.chainId,
  );

  factory WcSessionEventRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionEventRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionEventRequestToJson(this);
}
