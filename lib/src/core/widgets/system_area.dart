import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_clone/src/core/core.dart';

class SystemArea extends StatelessWidget {
  const SystemArea({
    super.key,
    required this.child,
    this.systemNavigationBarColor,
  });
  final Widget child;
  final Color? systemNavigationBarColor;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: sysBrightness(context),
        statusBarIconBrightness: sysBrightness(context),
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: systemNavigationBarColor,
      ),
      child: child,
    );
  }
}
