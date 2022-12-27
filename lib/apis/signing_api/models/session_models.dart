import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/generic_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/proposal_models.dart';

part 'session_models.g.dart';

@JsonSerializable()
class BaseNamespace {
  final List<String> accounts;
  final List<String> methods;
  final List<String> events;

  BaseNamespace(
    this.accounts,
    this.methods,
    this.events,
  );

  factory BaseNamespace.fromJson(Map<String, dynamic> json) =>
      _$BaseNamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$BaseNamespaceToJson(this);
}

@JsonSerializable()
class Namespace extends BaseNamespace {
  final List<BaseNamespace> extension;

  Namespace(
    this.extension,
    List<String> accounts,
    List<String> methods,
    List<String> events,
  ) : super(
          accounts,
          methods,
          events,
        );

  factory Namespace.fromJson(Map<String, dynamic> json) =>
      _$NamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$NamespaceToJson(this);
}

@JsonSerializable()
class SessionData {
  String topic;
  Relay relay;
  int expiry;
  bool acknowledged;
  String controller;
  Map<String, Namespace> namespaces;
  Map<String, RequiredNamespace>? requiredNamespaces;
  ConnectionMetadata self;
  ConnectionMetadata peer;

  SessionData(
    this.topic,
    this.relay,
    this.expiry,
    this.acknowledged,
    this.controller,
    this.namespaces,
    this.self,
    this.peer, {
    this.requiredNamespaces,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);
}
