
import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/issues/domain/domain.dart';
import 'package:github_clone/src/features/issues/presentation/widgets/comment_user_tile.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      marign: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentUserTile(
            url: comment.userAvatarUrl,
            username: comment.username,
            subtitle: comment.authorAssociation,
            trailing: comment.createdAt.long,
          ),
          Padding(
            padding: kPadding.copyWith(top: 0),
            child: MarkdownWidget(
              text: comment.body,
            ),
          ),
        ],
      ),
    );
  }
}
