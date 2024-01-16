import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';
import 'package:go_router/go_router.dart';

class RepositoryPage extends StatelessWidget {
  const RepositoryPage({super.key, required this.repoInfo});
  final RepoInfo repoInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: context.colorScheme.primary,
            scrolledUnderElevation: 2,
            shadowColor: Colors.transparent,
            forceElevated: true,
            floating: true,
            title: Text(
              repoInfo.name,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                RepositoryInfo(repoInfo: repoInfo),
                Padding(
                  padding: kPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Others",
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TileButton(
                        icon: Icons.warning_amber_rounded,
                        title: "Issues",
                        trailing: repoInfo.issues.str,
                        onTap: () {
                          context.pushNamed(
                            RouteName.issues.name,
                            queryParameters: {
                              "username": repoInfo.ownerName,
                              "repository": repoInfo.name,
                              "count": repoInfo.issues.toString(),
                            },
                          );
                        },
                      ),
                      TileButton(
                        icon: Icons.people_outline,
                        title: "Contributors",
                        onTap: () {
                          context.pushNamed(
                            RouteName.users.name,
                            queryParameters: {
                              "username": repoInfo.ownerName,
                              "repository": repoInfo.name,
                              "usersType":
                                  UsersType.repoContributors.index.toString(),
                            },
                          );
                          // context.push(
                          //   "/contributors/${repoInfo.ownerName}/${repoInfo.name}",
                          // );
                        },
                      ),
                      TileButton(
                        icon: Icons.folder_open_rounded,
                        title: "Code",
                        onTap: () {
                          context.push(
                            "/contents/${repoInfo.ownerName}/${repoInfo.name}",
                            extra: [true, "/"],
                          );
                        },
                      ),
                      Text(
                        "Readme",
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ReadmeWidget(
                          username: repoInfo.ownerName,
                          repository: repoInfo.name,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
