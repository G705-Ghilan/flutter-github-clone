import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Oops")),
      content: Text(text, style: context.textTheme.labelMedium),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Ok"),
        ),
      ],
    );
  }

  static show(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(text: text),
    );
  }
}
