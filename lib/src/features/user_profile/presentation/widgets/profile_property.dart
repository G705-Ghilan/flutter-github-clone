import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_clone/src/core/core.dart';

class ProfileProperty extends StatelessWidget {
  const ProfileProperty({
    super.key,
    required this.text,
    required this.icon,
    this.focus = false,
    this.onTap,
    this.primaryContainer = true,
  });
  final String text;
  final IconData icon;
  final bool focus;
  final void Function()? onTap;
  final bool primaryContainer;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      radius: kRadius / 2,
      onTap: onTap,
      elevation: 10,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      enabled: primaryContainer,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: context.textTheme.labelMedium?.copyWith(
              color: focus ? null : context.colorScheme.onSurfaceVariant,
            ),
          )
        ],
      ),
    );
  }
}
