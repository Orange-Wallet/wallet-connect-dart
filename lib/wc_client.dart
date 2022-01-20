import 'dart:convert';
import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:wallet_connect/models/ethereum/wc_ethereum_sign_message.dart';
import 'package:wallet_connect/models/ethereum/wc_ethereum_transaction.dart';
import 'package:wallet_connect/models/exception/exceptions.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_error.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_error_response.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_request.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_response.dart';
import 'package:wallet_connect/models/message_type.dart';
import 'package:wallet_connect/models/session/wc_approve_session_response.dart';
import 'package:wallet_connect/models/session/wc_session.dart';
import 'package:wallet_connect/models/session/wc_session_request.dart';
import 'package:wallet_connect/models/session/wc_session_update.dart';
import 'package:wallet_connect/models/wc_encryption_payload.dart';
import 'package:wallet_connect/models/wc_method.dart';
import 'package:wallet_connect/models/wc_peer_meta.dart';
import 'package:wallet_connect/models/wc_socket_message.dart';
import 'package:wallet_connect/wc_cipher.dart';
import 'package:wallet_connect/wc_session_store.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:math';

typedef SessionRequest = void Function(int id, WCPeerMeta peerMeta);
typedef SessionUpdate = void Function(int id, WCSessionUpdate sessionUpdate);
typedef SessionApproved = void Function(
    int id, WCApproveSessionResponse response);
typedef SocketError = void Function(dynamic message);
typedef SocketClose = void Function(int? code, String? reason);
typedef EthSign = void Function(int id, WCEthereumSignMessage message);
typedef EthTransaction = void Function(
    int id, WCEthereumTransaction transaction);
typedef CustomRequest = void Function(int id, String payload);

class WCClient {
  late WebSocketChannel _webSocket;
  Stream _socketStream = Stream.empty();
  // ignore: close_sinks
  WebSocketSink? _socketSink;
  WCSession? _session;
  WCPeerMeta? _peerMeta;
  WCPeerMeta? _remotePeerMeta;
  int _handshakeId = -1;
  int? _chainId;
  String? _peerId;
  String? _remotePeerId;
  bool _isConnected = false;

  WCClient({
    this.onSessionRequest,
    this.onSessionUpdate,
    this.onFailure,
    this.onDisconnect,
    this.onEthSign,
    this.onEthSignTransaction,
    this.onEthSendTransaction,
    this.onCustomRequest,
    this.onConnect,
    this.onSessionApproved,
  });

  final SessionRequest? onSessionRequest;
  final SessionUpdate? onSessionUpdate;
  final SocketError? onFailure;
  final SocketClose? onDisconnect;
  final EthSign? onEthSign;
  final EthTransaction? onEthSignTransaction, onEthSendTransaction;
  final CustomRequest? onCustomRequest;
  final SessionApproved? onSessionApproved;
  final Function()? onConnect;

  final _random = new Random();
  final _requestIDMap = new Map<int, JsonRpcRequest>();

  WCSession? get session => _session;
  WCPeerMeta? get peerMeta => _peerMeta;
  WCPeerMeta? get remotePeerMeta => _remotePeerMeta;
  int? get chainId => _chainId;
  String? get peerId => _peerId;
  String? get remotePeerId => _remotePeerId;
  bool get isConnected => _isConnected;
  bool isWallet = true;

  connectNewSession({
    required WCSession session,
    required WCPeerMeta peerMeta,
    bool isWallet = true,
  }) {
    this.isWallet = isWallet;

    _connect(
      session: session,
      peerMeta: peerMeta,
    );
  }

  connectFromSessionStore({
    required WCSessionStore sessionStore,
    bool isWallet = true,
  }) {
    this.isWallet = isWallet;

    _connect(
      fromSessionStore: true,
      session: sessionStore.session,
      peerMeta: sessionStore.peerMeta,
      remotePeerMeta: sessionStore.remotePeerMeta,
      peerId: sessionStore.peerId,
      remotePeerId: sessionStore.remotePeerId,
      chainId: sessionStore.chainId,
    );
  }

  WCSessionStore get sessionStore => WCSessionStore(
        session: _session!,
        peerMeta: _peerMeta!,
        peerId: _peerId!,
        remotePeerId: _remotePeerId!,
        remotePeerMeta: _remotePeerMeta!,
        chainId: _chainId!,
      );

  approveSession({required List<String> accounts, int? chainId}) {
    if (_handshakeId <= 0) {
      throw HandshakeException();
    }

    if (chainId != null) _chainId = chainId;
    final result = WCApproveSessionResponse(
      chainId: _chainId,
      accounts: accounts,
      peerId: _peerId!,
      peerMeta: _peerMeta!,
    );
    final response = JsonRpcResponse<Map<String, dynamic>>(
      id: _handshakeId,
      result: result.toJson(),
    );
    print('approveSession ${jsonEncode(response.toJson())}');
    onConnect?.call();
    _encryptAndSend(jsonEncode(response.toJson()));
  }

  Future<void> updateSession({
    List<String>? accounts,
    int? chainId,
    bool approved = true,
  }) async {
    final param = WCSessionUpdate(
      approved: approved,
      chainId: _chainId ?? chainId,
      accounts: accounts,
    );
    final request = JsonRpcRequest(
      id: DateTime.now().millisecondsSinceEpoch,
      method: WCMethod.SESSION_UPDATE,
      params: [param.toJson()],
    );
    return _encryptAndSend(jsonEncode(request.toJson()));
  }

  rejectSession({String message = "Session rejected"}) {
    if (_handshakeId <= 0) {
      throw HandshakeException();
    }

    final response = JsonRpcErrorResponse(
      id: _handshakeId,
      error: JsonRpcError.serverError(message),
    );
    _encryptAndSend(jsonEncode(response.toJson()));
  }

  approveRequest<T>({
    required int id,
    required T result,
  }) {
    final response = JsonRpcResponse<T>(
      id: id,
      result: result,
    );
    _encryptAndSend(jsonEncode(response.toJson()));
  }

  rejectRequest({
    required int id,
    String message = "Reject by the user",
  }) {
    final response = JsonRpcErrorResponse(
      id: id,
      error: JsonRpcError.serverError(message),
    );
    _encryptAndSend(jsonEncode(response.toJson()));
  }

  _connect({
    required WCSession session,
    required WCPeerMeta peerMeta,
    bool fromSessionStore = false,
    WCPeerMeta? remotePeerMeta,
    String? peerId,
    String? remotePeerId,
    int? chainId,
  }) {
    if (session == WCSession.empty()) {
      throw InvalidSessionException();
    }

    peerId ??= Uuid().v4();
    _session = session;
    _peerMeta = peerMeta;
    _remotePeerMeta = remotePeerMeta;
    _peerId = peerId;
    _remotePeerId = remotePeerId;
    _chainId = chainId;
    final bridgeUri =
        Uri.parse(session.bridge.replaceAll('https://', 'wss://'));
    _webSocket = WebSocketChannel.connect(bridgeUri);
    _isConnected = true;
    onConnect?.call();
    _socketStream = _webSocket.stream;
    _socketSink = _webSocket.sink;
    _listen();
    if (this.isWallet) {
      _subscribe(session.topic);
    } else {
      _sendSessionRequest();
    }
    _subscribe(peerId);
  }

  disconnect() {
    _socketSink!.close(WebSocketStatus.normalClosure);
  }

  _sendSessionRequest() {
    if (chainId != null) _chainId = chainId;
    final param = WCSessionRequest(
      peerId: _peerId!,
      peerMeta: _peerMeta!,
      chainId: _chainId,
    );
    final request = JsonRpcRequest(
      id: DateTime.now().millisecondsSinceEpoch * 1000 + _random.nextInt(1000),
      method: WCMethod.SESSION_REQUEST,
      params: [param.toJson()],
    );

    _requestIDMap[request.id] = request;

    return _encryptAndSend(jsonEncode(request.toJson()));
  }

  _subscribe(String topic) {
    final message = WCSocketMessage(
      topic: topic,
      type: MessageType.SUB,
      payload: '',
    ).toJson();
    _socketSink!.add(jsonEncode(message));
  }

  _invalidParams(int id) {
    final response = JsonRpcErrorResponse(
      id: id,
      error: JsonRpcError.invalidParams("Invalid parameters"),
    );
    _encryptAndSend(jsonEncode(response.toJson()));
  }

  Future<void> _encryptAndSend(String result) async {
    print('send payload: $result');
    final payload = await WCCipher.encrypt(result, _session!.key);
    print('encrypted $payload');
    final message = WCSocketMessage(
      topic: _remotePeerId ?? _session!.topic,
      type: MessageType.PUB,
      payload: jsonEncode(payload.toJson()),
    );
    print('message ${jsonEncode(message.toJson())}');
    _socketSink!.add(jsonEncode(message.toJson()));
  }

  _listen() {
    _socketStream.listen(
      (event) async {
        print('DATA: $event ${event.runtimeType}');
        final Map<String, dynamic> decoded = json.decode("$event");
        print('DECODED: $decoded ${decoded.runtimeType}');
        final socketMessage = WCSocketMessage.fromJson(jsonDecode("$event"));
        final decryptedMessage = await _decrypt(socketMessage);
        _handleMessage(decryptedMessage);
      },
      onError: (error) {
        print('onError $_isConnected CloseCode ${_webSocket.closeCode} $error');
        _resetState();
        onFailure?.call('$error');
      },
      onDone: () {
        if (_isConnected) {
          print(
              'onDone $_isConnected CloseCode ${_webSocket.closeCode} ${_webSocket.closeReason}');
          _resetState();
          onDisconnect?.call(_webSocket.closeCode, _webSocket.closeReason);
        }
      },
    );
  }

  Future<String> _decrypt(WCSocketMessage socketMessage) async {
    final payload =
        WCEncryptionPayload.fromJson(jsonDecode(socketMessage.payload));
    final decrypted = await WCCipher.decrypt(payload, _session!.key);
    print("DECRYPTED: $decrypted");
    return decrypted;
  }

  _handleMessage(String payload) {
    try {
      if (this.isWallet) {
        final request = JsonRpcRequest.fromJson(jsonDecode(payload));
        if (request.method != null) {
          _handleRequest(request);
        } else {
          onCustomRequest?.call(request.id, payload);
        }
      } else {
        final response = JsonRpcResponse.fromJson(jsonDecode(payload));
        final originalRequest = _requestIDMap[response.id];
        if (originalRequest != null) {
          if (response.result != null) {
            _handleResponse(response, originalRequest);
          } else {
            final error = JsonRpcErrorResponse.fromJson(jsonDecode(payload));
            _handleError(error, originalRequest);
          }
        } else {
          // try to cast if it's a request
          final request = JsonRpcRequest.fromJson(jsonDecode(payload));
          if (request.method != null) {
            _handleRequest(request);
          } else {
            print("Unknown message: $response");
          }
        }
      }
    } on InvalidJsonRpcParamsException catch (e) {
      _invalidParams(e.requestId);
    }
  }

  _handleRequest(JsonRpcRequest request) {
    if (request.params == null) throw InvalidJsonRpcParamsException(request.id);

    switch (request.method) {
      case WCMethod.SESSION_REQUEST:
        final param = WCSessionRequest.fromJson(request.params!.first);
        print('SESSION_REQUEST $param');
        _handshakeId = request.id;
        _remotePeerId = param.peerId;
        _remotePeerMeta = param.peerMeta;
        _chainId = param.chainId;
        onSessionRequest?.call(request.id, param.peerMeta);
        break;
      case WCMethod.SESSION_UPDATE:
        final param = WCSessionUpdate.fromJson(request.params!.first);
        print('SESSION_UPDATE $param');
        if (!param.approved) {
          killSession();
        }
        onSessionUpdate?.call(request.id, param);
        break;
      case WCMethod.ETH_SIGN:
        print('ETH_SIGN $request');
        final params = request.params!.cast<String>();
        if (params.length < 2) {
          throw InvalidJsonRpcParamsException(request.id);
        }

        onEthSign?.call(
          request.id,
          WCEthereumSignMessage(
            raw: params,
            type: WCSignType.MESSAGE,
          ),
        );
        break;
      case WCMethod.ETH_PERSONAL_SIGN:
        print('ETH_PERSONAL_SIGN $request');
        final params = request.params!.cast<String>();
        if (params.length < 2) {
          throw InvalidJsonRpcParamsException(request.id);
        }

        onEthSign?.call(
          request.id,
          WCEthereumSignMessage(
            raw: params,
            type: WCSignType.PERSONAL_MESSAGE,
          ),
        );
        break;
      case WCMethod.ETH_SIGN_TYPE_DATA:
        print('ETH_SIGN_TYPE_DATA $request');
        final params = request.params!.cast<String>();
        if (params.length < 2) {
          throw InvalidJsonRpcParamsException(request.id);
        }

        onEthSign?.call(
          request.id,
          WCEthereumSignMessage(
            raw: params,
            type: WCSignType.TYPED_MESSAGE,
          ),
        );
        break;
      case WCMethod.ETH_SIGN_TRANSACTION:
        print('ETH_SIGN_TRANSACTION $request');
        final param = WCEthereumTransaction.fromJson(request.params!.first);
        onEthSignTransaction?.call(request.id, param);
        break;
      case WCMethod.ETH_SEND_TRANSACTION:
        print('ETH_SEND_TRANSACTION $request');
        final param = WCEthereumTransaction.fromJson(request.params!.first);
        onEthSendTransaction?.call(request.id, param);
        break;
      default:
    }
  }

  _handleResponse(JsonRpcResponse response, JsonRpcRequest originalRequest) {
    if (response.id < 0) throw InvalidJsonRpcParamsException(response.id);
    switch (originalRequest.method) {
      case WCMethod.SESSION_REQUEST:
        final result = WCApproveSessionResponse.fromJson(response.result);
        onSessionApproved?.call(response.id, result);
        break;
      default:
        print("Unhandled response: $response");
    }
  }

  _handleError(
      JsonRpcErrorResponse errorResponse, JsonRpcRequest originalRequest) {
    print("handle error: $errorResponse");
    if (errorResponse.error.code == 32000) {
      killSession();
    }
  }

  killSession() async {
    await updateSession(approved: false);
    disconnect();
  }

  _resetState() {
    _handshakeId = -1;
    _isConnected = false;
    _session = null;
    _peerId = null;
    _remotePeerId = null;
    _remotePeerMeta = null;
    _peerMeta = null;
  }
}
