import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';
import 'package:go_router/go_router.dart';

class RepositoryInfo extends StatelessWidget {
  const RepositoryInfo({
    super.key,
    required this.repoInfo,
  });

  final RepoInfo repoInfo;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      radius: BorderRadius.zero,
      padding: kPadding.copyWith(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImage(
                url: repoInfo.ownerAvatarUrl,
                skeletonSize: 25,
                width: 25,
                radius: kRadius / 1.9,
              ),
              const SizedBox(width: 4),
              InkWell(
                borderRadius: kRadius / 1.9,
                onTap: () {
                  context.push("/profile/${repoInfo.ownerName}");
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Text(
                    repoInfo.ownerName.toUpperCase(),
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            repoInfo.name,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (repoInfo.description != null) ...[
            Text(repoInfo.description!),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 8),
          Wrap(
            direction: Axis.vertical,
            spacing: 5,
            children: [
              if (repoInfo.homePage != null &&
                  repoInfo.homePage!.trim().isNotEmpty)
                ProfileProperty(
                  icon: Icons.link,
                  text: repoInfo.homePage!,
                ),
              ProfileProperty(
                text: repoInfo.visibility,
                icon: Icons.lock_outline_rounded,
              ),
              ProfileProperty(
                text: repoInfo.createdAt.format,
                icon: Icons.calendar_today_rounded,
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(),
          ),
          Row(
            children: [
              Expanded(
                child: FollowButton(
                  number: repoInfo.stars,
                  text: "Stars",
                  onTap: () {
                    context.pushNamed(
                      "users",
                      queryParameters: {
                        "username": repoInfo.ownerName,
                        "repository": repoInfo.name,
                        "usersType": UsersType.repoStars.index.toString(),
                        "count": repoInfo.stars.toString(),
                      },
                    );
                    // context.push(
                    //   "/stars/${repoInfo.ownerName}/${repoInfo.name}",
                    //   extra: repoInfo.stars,
                    // );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FollowButton(
                  number: repoInfo.forks,
                  text: "Forks",
                  onTap: () {
                    context.pushNamed(
                      "repositories",
                      queryParameters: {
                        "username": repoInfo.ownerName,
                        "repository": repoInfo.name,
                        "reposType": ReposType.repoForks.index.toString(),
                        "count": repoInfo.forks.toString(),
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: FollowButton(
                  number: repoInfo.wachers,
                  text: "Watchers",
                  onTap: () {
                    context.pushNamed(
                      "users",
                      queryParameters: {
                        "username": repoInfo.ownerName,
                        "repository": repoInfo.name,
                        "usersType": UsersType.repoWachers.index.toString(),
                        "count": repoInfo.wachers.toString(),
                      },
                    );
                    // context.push(
                    //   "/watchers/${repoInfo.ownerName}/${repoInfo.name}",
                    //   extra: repoInfo.wachers,
                    // );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
