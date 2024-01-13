import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_clone/src/src.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.url,
    this.width,
    required this.skeletonSize,
    this.primary = true,
    this.radius,
  });
  final String url;
  final double? width;
  final double skeletonSize;
  final bool primary;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? kRadius * 5,
      child: PrimaryContainer(
        padding: EdgeInsets.zero,
        elevation: 10,
        enabled: primary,
        child: Skeleton.replace(
          width: skeletonSize,
          height: skeletonSize,
          child: CachedNetworkImage(
            imageUrl: url,
            width: width,
            errorWidget: (context, url, error) {
              return const FittedBox(
                child: Text(
                  "?",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
