import 'package:flutter/material.dart';
import 'package:github_clone/src/src.dart';
import 'package:go_router/go_router.dart';

class FollowerItem extends StatelessWidget {
  const FollowerItem({super.key, required this.follower});
  final User follower;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: EdgeInsets.zero,
      marign: const EdgeInsets.symmetric(vertical: 6),
      onTap: () {
        context.push("/profile/${follower.name}");
      },
      child: ListTile(
        leading: PrimaryContainer(
          padding: EdgeInsets.zero,
          elevation: 10,
          radius: kRadius * 10,
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: CustomImage(
                url: follower.avatarUrl,
                skeletonSize: 100,
              )),
        ),
        title: Text(follower.name),
        subtitle: follower.contributions != null
            ? Text("${follower.contributions} Contributions")
            : null,
      ),
    );
  }
}
