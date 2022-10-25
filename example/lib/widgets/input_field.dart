import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  final String title;
  final String label;
  const InputDialog({
    Key? key,
    required this.title,
    required this.label,
  }) : super(key: key);

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.title),
      titlePadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, .0),
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        TextField(
          onChanged: (v) => setState(() {
            value = v;
          }),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text(widget.label),
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, value),
              child: Text('CONTINUE'),
            ),
          ],
        ),
      ],
    );
  }
}
