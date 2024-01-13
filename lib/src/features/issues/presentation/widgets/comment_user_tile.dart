import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:go_router/go_router.dart';

class CommentUserTile extends StatelessWidget {
  const CommentUserTile({
    super.key,
    required this.url,
    required this.username,
    required this.subtitle,
    required this.trailing,
    this.mainTile = false,
  });

  final String url;
  final String username;
  final String subtitle;
  final String trailing;
  final bool mainTile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mainTile ? 7 : 0),
      child: ListTile(
        onTap: () {
          context.push("/profile/$username");
        },
        contentPadding:
            mainTile ? const EdgeInsets.symmetric(horizontal: 7) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(12),
            bottom: Radius.circular(mainTile ? 12 : 0),
          ),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: CustomImage(
            url: url,
            skeletonSize: 100,
            primary: true,
          ),
        ),
        title: Text(username),
        trailing: Text(trailing),
        subtitle: subtitle != "NONE"
            ? Text(
                subtitle.toLowerCase(),
              )
            : null,
      ),
    );
  }
}
