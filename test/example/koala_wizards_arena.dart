import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_v2_dart/wallet_connect_v2.dart';

main() async {
  // 1. Get URI from QR Scanner
  const wizardsArenaQrURI =
      'wc:4f8cc6dd1ef31470739750c51f75e75f5a776e9ac07664219f1bc4223a3f0321@2?relay-protocol=irn&symKey=85f10246dc31add72933e7e31c55d1707dd0fd52518f9c7adb040eddd66ff72f';
  Uri uri = Uri.parse(wizardsArenaQrURI);
  print('uri = $uri');
  print('uri.scheme = ${uri.scheme}');

  // 2. Initiate wcClient
  const wcKoalaProjectId = 'c993e66665ac416812435c9f1f07a96c';
  SignClient wcClient = await SignClient.createInstance(
    Core(
      projectId: wcKoalaProjectId,
      memoryStore: true,
    ),
    self: PairingMetadata(
      'Koala Wallet',
      'Your Passport to the Kadena Ecosystem',
      'https://koalawallet.io',
      ['https://koalawallet.io/media/png/koala_color.png'],
    ),
  );

  // For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.
  late int id;
  wcClient.onSessionProposal.subscribe((SessionProposal? args) async {
    // Handle UI updates using the args.params
    // Keep track of the args.id for the approval response
    id = args!.id;
    print('args!.params.requiredNamespaces = ${args!.params.requiredNamespaces}');

    // approve session
    // // Present the UI to the user, and allow them to reject or approve the proposal
    final walletNamespaces = {
      'kadena': Namespace(
        accounts: [
          'kadena:mainnet01:k**cf415c73edb4666a967933bddc2e6c4a6e13b8ec0566e612b9f3cbe4a4d8506e',
          // yes this is correct. They replace ** with - on their end
          'kadena:testnet04:k**cf415c73edb4666a967933bddc2e6c4a6e13b8ec0566e612b9f3cbe4a4d8506e'
        ],
        methods: ['kadena_sign', 'kadena_quicksign'],
        events: ['kadena_transaction_updated'],
      ),
    };
    await wcClient.approve(
        ApproveParams(id: id, namespaces: walletNamespaces)); // This will have the accounts requested in params
  });

  // Also setup the namespaces and methods that your wallet supports
  final kadenaSignHandler = (dynamic params) async {
    // TODO implement signing
    return 'signed!';
  };
  wcClient.registerRequestHandler(
    'kadena',
    'kadena_sign',
    kadenaSignHandler,
  );

  final kadenaQuickSignHandler = (dynamic params) async {
    // TODO implement quick signing
    return 'signed!';
  };
  wcClient.registerRequestHandler(
    'kadena',
    'kadena_quicksign',
    kadenaQuickSignHandler,
  );

  PairingInfo pairingInfo = await wcClient.pair(PairParams(uri: uri));
  print('pairingInfo.topic = ${pairingInfo.topic}');
  print('pairingInfo.relay.protocol = ${pairingInfo.relay.protocol}');
  print('pairingInfo.peerMetadata = ${pairingInfo.peerMetadata}');

  await Future.delayed(Duration(seconds: 10000));
}
