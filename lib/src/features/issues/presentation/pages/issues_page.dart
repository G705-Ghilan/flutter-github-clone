import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/features/issues/presentation/widgets/widgets.dart';
import 'package:github_clone/src/src.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({
    super.key,
    this.count,
    required this.params,
  });
  final int? count;
  final IssuesParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: count != null ? "${count!.str} Issues" : "Issues",
            subtitle: params.query ?? "${params.username}/${params.repository}",
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
              create: (context) =>
                  sl<IssuesBloc>()..add(LoadIssuesEvent(params: params)),
              child: BlocBuilder<IssuesBloc, IssuesState>(
                builder: (context, state) {
                  if (state is ErrorLoadingIssues &&
                      state.issues.issues.isEmpty) {
                    return SliverFillRemaining(
                      child: PageMessage(
                        icon: Icons.error_outline_rounded,
                        text: getFailureMessage(state.failure),
                      ),
                    );
                  }
                  Issues? issues;
                  if (state.issues.issues.isNotEmpty) {
                    issues = state.issues;
                  }
                  if (state.issues.issues.isEmpty && state is LoadedIssues) {
                    return const SliverFillRemaining(
                      child: PageMessage(
                        text: "No Data",
                        icon: Icons.show_chart_rounded,
                      ),
                    );
                  }
                  final int length =
                      (issues?.issues.length ?? min(12, count ?? 12)) + 1;
                  return SliverPadding(
                    padding: kPadding,
                    sliver: SliverList.builder(
                      itemCount: length,
                      itemBuilder: (context, index) {
                        if (index >= length - 1) {
                          if (state.issues.hasMore) {
                            if (state is LoadedIssues) {
                              context
                                  .read<IssuesBloc>()
                                  .add(LoadMoreIssuesEvent(params: params));
                            }

                            return Padding(
                              padding: kPadding,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (state is! LoadingIssues)
                                    state is ErrorLoadingIssues
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
                        final issue = issues?.issues[index] ?? Issue.fake();
                        return ShimmerSkeletonizer(
                          enabled: issues == null,
                          child: IssueItem(
                            issue: issue,
                            onTap: () {
                              context.pushWithComplexData(
                                CommentsPage(
                                  params: issueParams(issue),
                                  issue: issue,
                                  count: issue.comments,
                                ),
                              );
                            },
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

  IssuesParams issueParams(Issue issue) {
    return IssuesParams(
      username: issue.realUsername,
      repository: issue.repository,
    );
  }
}
