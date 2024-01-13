import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';

class PrimaryContainer extends StatelessWidget {
  const PrimaryContainer({
    super.key,
    required this.child,
    this.onTap,
    this.padding = kPadding,
    this.marign = EdgeInsets.zero,
    this.elevation = 2,
    this.radius,
    this.enabled = true,
  });
  final Widget child;
  final void Function()? onTap;
  final EdgeInsets padding;
  final EdgeInsets marign;
  final double elevation;
  final BorderRadius? radius;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }
    return Padding(
      padding: marign,
      child: Material(
        surfaceTintColor: context.colorScheme.primary,
        elevation: elevation,
        borderRadius: radius ?? kRadius,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius ?? kRadius,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
