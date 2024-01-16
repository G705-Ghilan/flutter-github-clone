import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';
import 'package:go_router/go_router.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key, required this.user});
  final Profile user;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: kPadding.copyWith(top: 0),
      radius: BorderRadius.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImage(
                url: user.avatarUrl,
                skeletonSize: 60,
                width: 60,
                radius: kRadius / 1.5,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: context.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.login,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (user.bio != null) ...[
            Text(user.bio!),
            const SizedBox(height: 10),
          ],
          Wrap(
            direction: Axis.vertical,
            spacing: 5,
            children: [
              if (user.location != null)
                ProfileProperty(
                  icon: Icons.location_on_outlined,
                  text: user.location!,
                ),
              if (user.blog != null && user.blog!.trim().isNotEmpty)
                ProfileProperty(
                  icon: Icons.link_outlined,
                  text: user.blog!,
                  focus: true,
                ),
              if (user.email != null)
                ProfileProperty(
                  icon: Icons.email_outlined,
                  text: user.email!,
                ),
              if (user.twitterUsername != null)
                ProfileProperty(
                  icon: Icons.alternate_email_rounded,
                  text: "@${user.twitterUsername!}",
                  focus: true,
                ),
              ProfileProperty(
                icon: Icons.calendar_today_rounded,
                text: user.createdAt.format,
                focus: true,
              ),
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
                  number: user.followers,
                  text: "Followers",
                  onTap: () {
                    context.pushNamed(
                      RouteName.users.name,
                      queryParameters: {
                        "username": user.login,
                        "usersType": UsersType.followers.index.toString(),
                        "count": user.followers.toString(),
                      },
                    );
                    // context.push(
                    //   "/followers/${user.login}",
                    //   extra: user.followers,
                    // );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FollowButton(
                  number: user.following,
                  text: "Following",
                  onTap: () {
                    context.pushNamed(
                      RouteName.users.name,
                      queryParameters: {
                        "username": user.login,
                        "usersType": UsersType.following.index.toString(),
                        "count": user.following.toString(),
                      },
                    );
                    // context.push(
                    //   "/following/${user.login}",
                    //   extra: user.following,
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
