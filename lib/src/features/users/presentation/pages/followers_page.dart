import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/users/presentation/widgets/widgets.dart';
import 'package:github_clone/src/features/users/users.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({
    super.key,
    required this.count,
    required this.followParams,
  });
  final int? count;
  final UsersParams followParams;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        CustomSliverAppBar(
          title: count != null
              ? "${count!.str} ${followParams.usersType.eName}"
              : followParams.usersType.eName,
          subtitle: followParams.query ??
              followParams.repository ??
              followParams.username,
        ),
        if (count == 0)
          const SliverFillRemaining(
            child: PageMessage(
              text: "No Data",
              icon: Icons.show_chart_rounded,
            ),
          ),
        if (count != 0)
          BlocProvider(
            create: (context) => sl<UsersBloc>()
              ..add(
                LoadUsersEvent(params: followParams),
              ),
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is ErrorLoadingUsers && state.users.users.isEmpty) {
                  return SliverFillRemaining(
                    child: PageMessage(
                      icon: Icons.error_outline_rounded,
                      text: getFailureMessage(state.failure),
                    ),
                  );
                }
                Users? follow;
                if (state.users.users.isNotEmpty) {
                  follow = state.users;
                }

                if (state.users.users.isEmpty && state is LoadedUsers) {
                  return const SliverFillRemaining(
                    child: PageMessage(
                      text: "No Data",
                      icon: Icons.show_chart_rounded,
                    ),
                  );
                }
                final int length =
                    (follow?.users.length ?? min(12, count ?? 12)) + 1;
                return SliverPadding(
                  padding: kPadding,
                  sliver: SliverList.builder(
                    itemCount: length,
                    itemBuilder: (context, index) {
                      if (index >= length - 1) {
                        if (state.users.hasMore) {
                          if (state is LoadedUsers) {
                            context.read<UsersBloc>().add(
                                  LoadMoreUsersEvent(params: followParams),
                                );
                          }

                          return Padding(
                            padding: kPadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state is! LoadingUsers)
                                  state is ErrorLoadingUsers
                                      ? Expanded(
                                          child: Text(
                                            getFailureMessage(state.failure),
                                            textAlign: TextAlign.center,
                                            style:
                                                context.textTheme.labelMedium,
                                          ),
                                        )
                                      : const CircularProgressIndicator(),
                              ],
                            ),
                          );
                        }
                        return const SizedBox();
                      }
                      return ShimmerSkeletonizer(
                        enabled: follow == null,
                        child: FollowerItem(
                          follower: follow?.users[index] ?? User.fake(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
      ],
    ));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count != null
                ? "${count!.str} ${followParams.usersType.eName}"
                : followParams.usersType.eName,
            style: context.textTheme.titleMedium,
          ),
          Text(
            followParams.repository ?? followParams.username,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
