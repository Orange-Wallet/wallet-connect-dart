abstract class ICore {
  final String protocl = 'wc';
  final String version = '2';

  abstract final String name;
  abstract final String context;
  abstract final String relayUrl;
  abstract final String projectId;

  // abstract Logger logger;
  // abstract IHeartBeat heartbeat;
  // abstract ICrypto crypto;
  // abstract IRelayer relayer;
  // abstract IKeyValueStorage storage;
  // abstract IJsonRpcHistory history;
  // abstract IExpirer expirer;
  // abstract IPairing pairing;

  void start();
}
