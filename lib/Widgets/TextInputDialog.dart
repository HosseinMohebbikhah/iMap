// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class TextInputDialog extends StatelessWidget {
  late String title;
  late String loc;
  TextInputDialog({super.key, required this.title, required this.loc});

  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title),
         const SizedBox(
            height: 2,
          ),
          Text(
            loc,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textController1,
            decoration: const InputDecoration(labelText: 'Pin title'),
          ),
          TextField(
            controller: _textController2,
            decoration: const InputDecoration(labelText: 'Pin caption'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop([
              _textController1.text,
              _textController2.text,
            ]);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
