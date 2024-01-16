import 'package:flutter/material.dart';
import 'package:github_clone/src/src.dart';
import 'package:go_router/go_router.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      padding: EdgeInsets.zero,
      marign: const EdgeInsets.symmetric(vertical: 6),
      onTap: () {
        context.push("/profile/${user.name}");
      },
      child: ListTile(
        leading: PrimaryContainer(
          padding: EdgeInsets.zero,
          elevation: 10,
          radius: kRadius * 10,
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: CustomImage(
                url: user.avatarUrl,
                skeletonSize: 100,
              )),
        ),
        title: Text(user.name),
        subtitle: user.contributions != null
            ? Text("${user.contributions} Contributions")
            : null,
      ),
    );
  }
}
