import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/users/data/data.dart';
import 'package:github_clone/src/features/users/domain/domain.dart';

abstract class RemoteUsersDataSource {
  Future<UsersModel> getUsers(UsersParams params, [int page = 1]);
}

class RemoteUsersDataSourceImpl implements RemoteUsersDataSource {
  final DioClient client;

  RemoteUsersDataSourceImpl(this.client);

  @override
  Future<UsersModel> getUsers(UsersParams params, [int page = 1]) async {
    final response = await client.dio.get(
      getQueryByUserType(params),
      queryParameters: {"page": page},
      options: await client.refreshIfConnectedOption(),
    );

    if ([200, 304].contains(response.statusCode)) {
      final followers = [
        for (Map<String, dynamic> json in (params.usersType == UsersType.search
            ? response.data["items"]
            : response.data))
          UserModel.fromJson(json)
      ];
      return UsersModel(
        users: followers,
        page: page,
        hasMore: followers.length == 30,
      );
    }
    if (response.statusCode == 204) {
      return UsersModel(
        users: const [],
        page: page,
        hasMore: false,
      );
    }
    throw NoUserException();
  }

  String getQueryByUserType(UsersParams params) {
    switch (params.usersType) {
      case UsersType.starred:
        return "/users/${params.username}/starred";
      case UsersType.following:
        return "/users/${params.username}/following";
      case UsersType.followers:
        return "/users/${params.username}/followers";
      case UsersType.repoWachers:
        return "/repos/${params.username}/${params.repository}/watchers";
      case UsersType.repoStars:
        return "/repos/${params.username}/${params.repository}/stargazers";
      case UsersType.repoContributors:
        return "/repos/${params.username}/${params.repository}/contributors";
      case UsersType.search:
        return "/search/users?q=${params.query}";
    }
  }
}
