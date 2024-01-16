import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/dependencies_injection.dart';
import 'package:github_clone/src/features/issues/presentation/widgets/widgets.dart';
import 'package:github_clone/src/src.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({
    super.key,
    this.count,
    required this.params,
    required this.issue,
  });

  final int? count;
  final IssuesParams params;
  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: count != null ? "${count!.str} Comments" : "Comments",
            subtitle:
                "${params.username}/${params.repository} #${issue.number}",
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: kPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    issue.title,
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  ProfileProperty(
                    text: issue.state.toUpperCase(),
                    icon: Icons.circle_outlined,
                  )
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          SliverToBoxAdapter(
              child: CommentUserTile(
            url: issue.userAvatarUrl,
            username: issue.username,
            subtitle: issue.authorAssociation,
            trailing: issue.createdAt.long,
            mainTile: true,
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: kPadding.copyWith(top: 0),
              child: MarkdownWidget(
                text: issue.body?.toString() ?? "",
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          if (count == 0)
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: PageMessage(
                  text: "No Comments",
                  icon: Icons.comment_bank_outlined,
                ),
              ),
            ),
          if (count != 0)
            BlocProvider(
              create: (context) => sl<CommentsBloc>()
                ..add(
                  LoadCommentsEvent(
                    params: CommentsParams(
                      username: params.username,
                      repository: params.repository,
                      number: issue.number.toString(),
                    ),
                  ),
                ),
              child: BlocBuilder<CommentsBloc, CommentsState>(
                builder: (context, state) {
                  if (state is ErrorLoadingComments &&
                      state.comments.comments.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                        child: PageMessage(
                          icon: Icons.error_outline_rounded,
                          text: getFailureMessage(state.failure),
                        ),
                      ),
                    );
                  }
                  Comments? comments;
                  if (state.comments.comments.isNotEmpty) {
                    comments = state.comments;
                  }
                  if (state.comments.comments.isEmpty &&
                      state is LoadedComments) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                        child: PageMessage(
                          text: "No Data",
                          icon: Icons.show_chart_rounded,
                        ),
                      ),
                    );
                  }
                  final int length =
                      (comments?.comments.length ?? min(12, count ?? 12)) + 1;
                  return SliverPadding(
                    padding: kPadding,
                    sliver: SliverList.builder(
                      itemCount: length,
                      itemBuilder: (context, index) {
                        if (index >= length - 1) {
                          if (state.comments.hasMore) {
                            if (state is LoadedComments) {
                              context
                                  .read<CommentsBloc>()
                                  .add(LoadMoreCommentsEvent(
                                      params: CommentsParams(
                                    username: params.username,
                                    repository: params.repository,
                                    number: issue.number.toString(),
                                  )));
                            }

                            return Padding(
                              padding: kPadding,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (state is! LoadingComments)
                                    state is ErrorLoadingComments
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
                        final comment =
                            comments?.comments[index] ?? Comment.fake();
                        return ShimmerSkeletonizer(
                          enabled: comments == null,
                          child: CommentItem(comment: comment),
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
