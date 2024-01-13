import 'package:flutter/cupertino.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final router = GoRouter(
  initialLocation: "/profile/<DUSER>",
  redirect: (context, state) {
    if (sl<SharedPreferences>().getString("token") == null) {
      return "/signin";
    }
    return null;
  },
  routes: [
    GoRoute(
      path: "/profile/:username",
      pageBuilder: (context, state) {
        return CupertinoPage(
          key: state.pageKey,
          child: UserProfile(
            username: state.pathParameters["username"] ?? "<DUSER>",
          ),
        );
      },
    ),
    // dynamic page route
    GoRoute(
      path: "/users",
      name: "users",
      pageBuilder: (context, GoRouterState state) {
        final Map<String, String> query = state.uri.queryParameters;
        return CupertinoPage(
          key: state.pageKey,
          child: UsersPage(
            followParams: UsersParams(
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
      path: "/repositories",
      name: "repositories",
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
      path: "/issues",
      name: "issues",
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
      path: "/contents/:username/:repository",
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
    GoRoute(
      path: "/signin",
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const AuthPage(),
      ),
    ),
  ],
);
