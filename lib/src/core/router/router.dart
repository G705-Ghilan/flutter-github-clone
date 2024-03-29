import 'package:flutter/cupertino.dart';
import 'package:github_clone/dependencies_injection.dart';
import 'package:github_clone/src/features/features.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RouteName {
  signin("/"),
  profile("/profile/:username"),
  repositories("/repositories"),
  users("/users"),
  issues("/issues"),
  contents("/contents/:username/:repository");

  final String path;
  const RouteName(this.path);
}

final router = GoRouter(
  initialLocation: "/profile/<DUSER>",
  redirect: (context, state) {
    final bool isSignedIn = sl<SharedPreferences>().getString("token") != null;
    return isSignedIn ? null : RouteName.signin.path;
  },
  routes: [
    GoRoute(
      path: RouteName.signin.path,
      name: RouteName.signin.name,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const AuthPage(),
      ),
    ),
    GoRoute(
      path: RouteName.profile.path,
      name: RouteName.profile.name,
      pageBuilder: (context, state) {
        return CupertinoPage(
          key: state.pageKey,
          child: UserProfile(
            username: state.pathParameters["username"] ?? "<DUSER>",
          ),
        );
      },
    ),
    GoRoute(
      path: RouteName.users.path,
      name: RouteName.users.name,
      pageBuilder: (context, GoRouterState state) {
        final Map<String, String> query = state.uri.queryParameters;
        return CupertinoPage(
          key: state.pageKey,
          child: UsersPage(
            userParams: UsersParams(
              username: query["username"] ?? "",
              repository: query["repository"],
              query: query["query"],
              usersType: UsersType.values[int.parse(query["usersType"] ?? "0")],
            ),
            count: int.tryParse(query["count"] ?? ""),
          ),
        );
      },
    ),
    GoRoute(
      path: RouteName.repositories.path,
      name: RouteName.repositories.name,
      pageBuilder: (context, state) {
        final Map<String, String> query = state.uri.queryParameters;

        return CupertinoPage(
          key: state.pageKey,
          child: ReposPage(
            reposParams: ReposParams(
              username: query["username"] ?? "",
              repository: query["repository"],
              query: query["query"],
              reposType: ReposType.values[int.parse(query["reposType"] ?? "0")],
            ),
            count: int.tryParse(query["count"] ?? ""),
          ),
        );
      },
    ),
    GoRoute(
      path: RouteName.issues.path,
      name: RouteName.issues.name,
      pageBuilder: (context, state) {
        final Map<String, String> query = state.uri.queryParameters;

        return CupertinoPage(
          key: state.pageKey,
          child: IssuesPage(
            params: IssuesParams(
              username: query["username"] ?? "",
              repository: query["repository"] ?? "",
              query: query["query"],
            ),
            count: int.tryParse(query["count"] ?? ""),
          ),
        );
      },
    ),
    GoRoute(
      path: RouteName.contents.path,
      name: RouteName.contents.name,
      pageBuilder: (context, state) {
        final extra = state.extra as List<dynamic>;

        return CupertinoPage(
          key: state.pageKey,
          child: FilesPage(
            params: CodeParams(
              username: state.pathParameters["username"]!,
              repository: state.pathParameters["repository"]!,
              path: extra.lastOrNull ?? "",
            ),
            isFolder: extra.firstOrNull ?? true,
          ),
        );
      },
    ),
  ],
);
