import 'package:flutter/material.dart';
import 'package:github_clone/src/features/issues/presentation/widgets/label_item.dart';
import 'package:github_clone/src/src.dart';
import 'package:go_router/go_router.dart';

class IssueItem extends StatelessWidget {
  const IssueItem({
    super.key,
    required this.issue,
    this.onTap,
  });

  final Issue issue;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      marign: const EdgeInsets.only(bottom: 12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                url: issue.userAvatarUrl,
                skeletonSize: 20,
              ),
              const SizedBox(width: 2),
              InkWell(
                borderRadius: kRadius / 1.5,
                onTap: () {
                  context.push("/profile/${issue.username}");
                },
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    issue.username,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                issue.createdAt.long,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: issue.title,
              style: context.textTheme.titleMedium,
              children: [
                const WidgetSpan(child: SizedBox(width: 5)),
                TextSpan(
                    text: "#${issue.number}",
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ))
              ],
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (Label label in issue.labels) LabelItem(label: label),
            ],
          ),
          const SizedBox(height: 12),
          ProfileProperty(
            text: issue.comments.str,
            icon: Icons.comment_bank_outlined,
            primaryContainer: false,
          ),
        ],
      ),
    );
  }
}
