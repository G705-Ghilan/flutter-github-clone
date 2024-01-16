import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/dependencies_injection.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/repos/repos.dart';

class ReposPage extends StatelessWidget {
  const ReposPage({
    super.key,
    this.count,
    required this.reposParams,
  });
  final int? count;
  final ReposParams reposParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: count != null
                ? "${count!.str} ${reposParams.reposType.eName}"
                : reposParams.reposType.eName,
            subtitle: reposParams.query ??
                reposParams.repository ??
                reposParams.username,
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
              create: (context) => sl<ReposBloc>()
                ..add(
                  LoadReposEvent(params: reposParams),
                ),
              child: BlocBuilder<ReposBloc, ReposState>(
                builder: (context, state) {
                  if (state is ErrorLoadingRepos && state.repos.repos.isEmpty) {
                    return SliverFillRemaining(
                      child: PageMessage(
                        icon: Icons.error_outline_rounded,
                        text: getFailureMessage(state.failure),
                      ),
                    );
                  }
                  Repos? repos;
                  if (state.repos.repos.isNotEmpty) {
                    repos = state.repos;
                  }
                  if (state.repos.repos.isEmpty && state is LoadedRepos) {
                    return const SliverFillRemaining(
                      child: PageMessage(
                        text: "No Data",
                        icon: Icons.show_chart_rounded,
                      ),
                    );
                  }
                  final int length =
                      (repos?.repos.length ?? min(12, count ?? 12)) + 1;
                  return SliverPadding(
                    padding: kPadding,
                    sliver: SliverList.builder(
                      itemCount: length,
                      itemBuilder: (context, index) {
                        if (index >= length - 1) {
                          if (state.repos.hasMore) {
                            if (state is LoadedRepos) {
                              context.read<ReposBloc>().add(
                                    LoadMoreReposEvent(params: reposParams),
                                  );
                            }

                            return Padding(
                              padding: kPadding,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (state is! LoadReposEvent)
                                    state is ErrorLoadingRepos
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
                        final repo = repos?.repos[index] ?? RepoInfo.fake();
                        return ShimmerSkeletonizer(
                          enabled: repos == null,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: RepositoryItem(
                              repo: repo,
                              isCard: true,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
