import 'package:flutter/material.dart';
import 'package:wallet_connect/wallet_connect.dart';

class UpdateSessionView extends StatefulWidget {
  final WCClient client;
  final String address;
  const UpdateSessionView({
    Key? key,
    required this.client,
    required this.address,
  }) : super(key: key);

  @override
  State<UpdateSessionView> createState() => _UpdateSessionViewState();
}

class _UpdateSessionViewState extends State<UpdateSessionView> {
  late String chainId, account;

  @override
  void initState() {
    chainId = (widget.client.chainId ?? 1).toString();
    account = widget.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Update Session'),
      titlePadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, .0),
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        TextField(
          onChanged: (v) => setState(() {
            chainId = v;
          }),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Chain ID'),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          onChanged: (v) => setState(() {
            account = v;
          }),
          initialValue: account,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Wallet Address'),
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, [chainId, account]),
              child: Text('CONTINUE'),
            ),
          ],
        ),
      ],
    );
  }
}
