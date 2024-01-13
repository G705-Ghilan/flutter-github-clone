import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_clone/src/core/core.dart';

extension StringExtension on String {
  String path(String p) => "$this/$p";

    Future<void> copy(BuildContext context) async {
    await Clipboard.setData(
      ClipboardData(text: this),
    ).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.colorScheme.secondaryContainer,
          duration: const Duration(milliseconds: 400),
          content: Text(
            'Copied to clipboard',
            style: TextStyle(color: context.colorScheme.onSecondaryContainer),
          ),
        ),
      );
    });
  }
}
