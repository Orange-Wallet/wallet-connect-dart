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

/// METADATA AND REDIRECTS

class Metadata {
  final String name;
  final String description;
  final String url;
  final List<String> icons;
  final Redirect? redirect;

  Metadata(
    this.name,
    this.description,
    this.url,
    this.icons,
    this.redirect,
  );
}

class Redirect {
  final String? native;
  final String? universal;

  Redirect(
    this.native,
    this.universal,
  );
}

/// PAIRING AND RELAY

class Relay {
  final String protocol;
  final String? data;

  Relay(
    this.protocol,
    this.data,
  );
}

class Pairing {
  final String topic;
  final Relay relay;
  final Metadata peerMetadata;
  final int expiry;
  final bool active;

  Pairing(
    this.topic,
    this.relay,
    this.peerMetadata,
    this.expiry,
    this.active,
  );
}
