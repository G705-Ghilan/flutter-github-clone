import 'package:flutter/material.dart';
import 'package:github_clone/src/core/extensions/context.dart';

const kPadding = EdgeInsets.all(12);

final BorderRadius kRadius = BorderRadius.circular(12);

Brightness sysBrightness(BuildContext context) {
  return context.theme.brightness == Brightness.dark
      ? Brightness.light
      : Brightness.dark;
}

final ThemeData kLightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.primaries[4],
  ),
);

final ThemeData kDarkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.primaries[4],
    brightness: Brightness.dark,
  ),
);
