import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:markdown/markdown.dart' as md;

class NonCacheNetworkImage extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    String? src = element.attributes["src"];
    if (src != null) {
      return CachedNetworkImage(
        imageUrl: src,
        imageBuilder: imageBuilder,
        errorWidget: (context, url, error) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: context.colorScheme.errorContainer,
            ),
            child: Text(
              "Error: $error",
              style: TextStyle(color: context.colorScheme.onErrorContainer),
            ),
          );
        },
        fadeOutDuration: Duration.zero,
        progressIndicatorBuilder: (context, url, progress) {
          return LinearProgressIndicator(
            borderRadius: kRadius,
            minHeight: 10,
            value: progress.progress ?? 0,
          );
        },
      );
    }
    return super.visitElementAfterWithContext(
      context,
      element,
      preferredStyle,
      parentStyle,
    );
  }

  Widget imageBuilder(context, imageProvider) {
    Widget image = ClipRRect(
      borderRadius: kRadius,
      child: Image(image: imageProvider),
    );
    return image;

    // return GestureDetector(
    //   onTap: () {
    //     showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             title: const Text("Random Image"),
    //             content: InteractiveViewer(
    //               minScale: 0.5,
    //               maxScale: 2.0,
    //               child: image,
    //             ),
    //           );
    //         });
    //   },
    //   child: image,
    // );
  }
}
