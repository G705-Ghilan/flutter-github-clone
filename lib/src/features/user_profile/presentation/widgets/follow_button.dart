import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.number,
    required this.text,
    this.onTap,
  });
  final int number;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      elevation: 10,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              text: TextSpan(
                text: number.str,
                style: context.textTheme.labelLarge,
                children: [
                  TextSpan(
                    text: " $text",
                    style: context.textTheme.labelMedium,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
