import 'package:dio/dio.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/repos/data/data.dart';
import 'package:github_clone/src/features/repos/domain/domain.dart';

abstract class RemoteReposDataSource {
  Future<Repos> getRepos(ReposParams params, [int page = 1]);
  Future<List<RepoInfoModel>> getPopularRepos(String username);
}

class RemoteReposDataSourceImpl implements RemoteReposDataSource {
  final DioClient client;

  RemoteReposDataSourceImpl(this.client);

  @override
  Future<List<RepoInfoModel>> getPopularRepos(String username) async {
    final response = await client.dio.get(
      "/search/repositories",
      options: await client.refreshIfConnectedOption(),
      queryParameters: {
        "q": "user:$username",
        'sort': 'stars',
        'direction': 'desc',
        'per_page': 10,
      },
    );

    if ([200, 304].contains(response.statusCode)) {
      return [
        for (Map<String, dynamic> json in response.data["items"])
          RepoInfoModel.fromJson(json)
      ];
    }
    return [];
  }

  @override
  Future<Repos> getRepos(ReposParams params, [int page = 1]) async {
    final Response response = await client.dio.get(
      getUrlByReposParams(params),
      queryParameters: {"page": page},
      options: await client.refreshIfConnectedOption(),
    );
    if ([200, 304].contains(response.statusCode)) {
      final repos = [
        for (Map<String, dynamic> json in (params.reposType == ReposType.search
            ? response.data["items"]
            : response.data))
          RepoInfoModel.fromJson(json)
      ];
      return Repos(
        repos: repos,
        page: page,
        hasMore: repos.length == 30,
      );
    }

    throw NoUserException();
  }

  String getUrlByReposParams(ReposParams params) {
    switch (params.reposType) {
      case ReposType.userStarred:
        return "/users/${params.username}/starred";

      case ReposType.userRepos:
        return "/users/${params.username}/repos";
      case ReposType.repoForks:
        return "/repos/${params.username}/${params.repository}/forks";
      case ReposType.search:
        return "/search/repositories?q=${params.query}";
    }
  }
}
