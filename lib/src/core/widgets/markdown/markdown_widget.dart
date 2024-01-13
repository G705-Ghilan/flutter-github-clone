import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/themes/vs2015.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github_clone/src/core/core.dart';
import 'custom_code_block.dart';
import 'non_cache_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownWidget extends StatelessWidget {
  const MarkdownWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      selectable: true,
      data: text,
      shrinkWrap: true,
      builders: <String, MarkdownElementBuilder>{
        'code': CustomCodeBlockBuilder(),
        'img': NonCacheNetworkImage(),
      },
      onTapLink: (String text, String? data, String? more) {
        launchUrl(Uri.parse(data ?? text));
      },
      styleSheet: MarkdownStyleSheet(
        strong: const TextStyle(
          fontWeight: FontWeight.w900,
        ),
        code: TextStyle(
          backgroundColor: Colors.transparent,
          color: context.colorScheme.onSecondaryContainer,
        ),
        codeblockDecoration: BoxDecoration(
          color: vs2015Theme['root']?.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      imageBuilder: (uri, title, alt) {
        return CachedNetworkImage(
          imageUrl: uri.toString(),
          imageBuilder: (context, imageProvider) {
            return ClipRRect(
              borderRadius: kRadius,
              child: Image(image: imageProvider),
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: context.colorScheme.errorContainer,
              ),
              child: Text(
                "($title, $alt, $error)",
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
      },
    );
  }
}
