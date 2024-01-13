import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShimmerSkeletonizer extends StatelessWidget {
  const ShimmerSkeletonizer({
    super.key,
    required this.child,
    this.enabled = true,
  });
  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      effect: shimmer(context),
      child: child,
    );
  }

  ShimmerEffect shimmer(BuildContext context) {
    if (context.theme.brightness == Brightness.dark) {
      return ShimmerEffect(
        baseColor: context.colorScheme.outlineVariant,
        highlightColor: context.colorScheme.onSurface.withOpacity(0.5),
      );
    }
    return ShimmerEffect(
      baseColor: context.colorScheme.primary.withOpacity(0.15),
      highlightColor: context.colorScheme.surface.withOpacity(0.2),
    );
  }
}
