import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/user_profile/user_profile.dart';
import 'package:go_router/go_router.dart';

class RepositoryItem extends StatelessWidget {
  const RepositoryItem({
    super.key,
    required this.repo,
    this.onTap,
    this.isCard = false,
  });
  final RepoInfo repo;
  final void Function()? onTap;
  final bool isCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screen.width / 1.4,
      height: isCard ? null : 180,
      child: PrimaryContainer(
        padding: kPadding,
        // elevation: 10,
        onTap: onTap ??
            () {
              context.pushWithComplexData(
                RepositoryPage(
                  repoInfo: repo,
                ),
              );
            },
        marign:
            isCard ? EdgeInsets.zero : EdgeInsets.only(right: kPadding.right),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(
                  url: repo.ownerAvatarUrl,
                  skeletonSize: 20,
                ),
               
                const SizedBox(width: 2),
                InkWell(
                  borderRadius: kRadius / 1.5,
                  onTap: () {
                    context.push("/profile/${repo.ownerName}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      repo.ownerName,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              repo.name,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 3),
            if (repo.description != null)
              Text(
                repo.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            isCard ? const SizedBox(height: 12) : const Spacer(),
            Row(
              children: [
                ProfileProperty(
                  text: repo.stars.str,
                  icon: Icons.star_border_rounded,
                  primaryContainer: false,
                ),
                const SizedBox(width: 12),
                if (repo.language != null)
                  ProfileProperty(
                    text: repo.language!,
                    icon: Icons.info_outline,
                    primaryContainer: false,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
