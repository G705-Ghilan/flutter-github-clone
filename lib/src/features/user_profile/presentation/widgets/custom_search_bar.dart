import 'package:flutter/material.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';
import 'package:github_clone/src/features/users/domain/domain.dart';
import 'package:go_router/go_router.dart';

class CustomSearchBar extends SearchDelegate {
  @override
  void showResults(BuildContext context) {}

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isEmpty) {
      return const SizedBox();
    }
    return ListView(
      padding: kPadding,
      children: [
        PrimaryContainer(
          padding: EdgeInsets.zero,
          marign: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text("User: '$query'"),
            leading: const Icon(Icons.person_outline_rounded),
          ),
          onTap: () {
            context.pushNamed(
              "users",
              queryParameters: {
                "usersType": UsersType.search.index.toString(),
                "query": query.trim(),
              },
            );
          },
        ),
        PrimaryContainer(
          padding: EdgeInsets.zero,
          marign: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text("Issues: '$query'"),
            leading: const Icon(Icons.circle_outlined),
          ),
          onTap: () {
            context.pushNamed(
              "issues",
              queryParameters: {"query": query.trim()},
            );
          },
        ),
        PrimaryContainer(
          padding: EdgeInsets.zero,
          marign: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text("Repository: '$query'"),
            leading: const Icon(Icons.merge_rounded),
          ),
          onTap: () {
            context.pushNamed(
              "repositories",
              queryParameters: {
                "query": query.trim(),
                "reposType": ReposType.search.index.toString(),
              },
            );
          },
        ),
      ],
    );
  }
}
