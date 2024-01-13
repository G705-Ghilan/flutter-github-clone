import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screen => mediaQuery.size;

  // theme
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  GoRouterState get routerState => GoRouterState.of(this);

  Future<T?> pushWithComplexData<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      CupertinoPageRoute(
        builder: (BuildContext context) => page,
      ),
    );
  }
}
