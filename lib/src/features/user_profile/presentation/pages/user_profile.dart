import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';
import 'package:go_router/go_router.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<UserProfileBloc>()..add(GetUserProfileEvent(username));

        return bloc;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              surfaceTintColor: context.colorScheme.primary,
              scrolledUnderElevation: 2,
              shadowColor: Colors.transparent,
              forceElevated: true,
              floating: true,
              actions: [
                if (username == "<DUSER>")
                  IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: CustomSearchBar());
                    },
                    icon: const Icon(Icons.search_rounded),
                  ),
                const SizedBox(width: 12),
              ],
              title: Text(
                username == "<DUSER>" ? "My Profile" : username,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            profile(username),
          ],
        ),
      ),
    );
  }

  Wrap popular(BuildContext context) {
    return Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: kPadding,
          child: Text(
            "Popular",
            style: context.textTheme.titleMedium,
          ),
        ),
        // Divider(),
        SizedBox(
          height: 180,
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            buildWhen: (previous, current) => current is PopularState,
            builder: popularBuilder,
          ),
        )
      ],
    );
  }

  BlocBuilder<UserProfileBloc, UserProfileState> profile(String username) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      buildWhen: (previous, current) => current is ProfileCardState,
      builder: (context, state) {
        if (state is ErrorloadingProfile) {
          return SliverFillRemaining(
            child: PageMessage(
              icon: Icons.error_outline_rounded,
              text: getFailureMessage(state.failure),
            ),
          );
        }
        Profile user = Profile.fake();
        if (state is LoadedProfile) {
          user = state.profile;
        }
        return pageContent(context, user);
      },
    );
  }

  Widget popularBuilder(BuildContext context, UserProfileState state) {
    if (state is ErrorLoadingPopular) {
      return PageMessage(
        icon: Icons.error_outline_rounded,
        text: getFailureMessage(state.failure),
      );
    }

    List<RepoInfo>? repos;
    if (state is LoadedPopualr) {
      repos = state.repos;
    }
    if (repos?.isEmpty ?? false || state is EmptyPopular) {
      return const PageMessage(
        text: "No Data",
        icon: Icons.show_chart_rounded,
      );
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: repos?.length ?? 10,
      padding: kPadding.copyWith(top: 0),
      itemBuilder: (context, index) {
        return ShimmerSkeletonizer(
          enabled: repos == null,
          child: RepositoryItem(
            repo: repos?[index] ?? RepoInfo.fake(),
          ),
        );
      },
    );
  }

  Widget pageContent(BuildContext context, Profile user) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ShimmerSkeletonizer(
            enabled: user.id == 0,
            child: ProfileInfo(
              user: user,
            ),
          ),
          popular(context),
          Padding(
            padding: kPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Work",
                  style: context.textTheme.titleMedium,
                ),
                ShimmerSkeletonizer(
                  enabled: user.id == 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      TileButton(
                        icon: Icons.book_outlined,
                        title: "Repositories",
                        trailing: user.repositories.str,
                        onTap: () {
                          context.pushNamed(
                            "repositories",
                            queryParameters: {
                              "username": user.login,
                              "reposType": ReposType.userRepos.index.toString(),
                              "count": user.repositories.toString(),
                            },
                          );
                        },
                      ),
                      TileButton(
                        icon: Icons.star_border_rounded,
                        title: "Starred",
                        onTap: () {
                          context.pushNamed(
                            "repositories",
                            queryParameters: {
                              "username": user.login,
                              "reposType":
                                  ReposType.userStarred.index.toString(),
                            },
                          );
                          // context.push("/starredRepos/${user.login}");
                        },
                      ),
                      Text(
                        "Readme",
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      // this will only work fine in release mode
                      // to be able to cache errors currectly
                      if (!kDebugMode)
                        if (user.id != 0) ...[
                          SizedBox(
                            width: double.infinity,
                            child: ReadmeWidget(username: user.login),
                          ),
                        ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
