import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/user_profile/data/data.dart';

abstract class RemoteUserProfileDataSource {
  Future<ProfileModel> getUserProfile(String username);
  Future<List<RepoInfoModel>> getPopularRepos(String username);
}

class RemoteUserProfileDataSourceImpl implements RemoteUserProfileDataSource {
  final DioClient client;

  RemoteUserProfileDataSourceImpl(this.client);

  @override
  Future<ProfileModel> getUserProfile(String username) async {
    final String path = username == "<DUSER>" ? "/user" : "/users/$username";
    final response = await client.dio.get(
      path,
      options: await client.refreshIfConnectedOption(),
    );
    
    // 200 -> network data
    // 304 -> cache data from hive box
    if ([200, 304].contains(response.statusCode)) {
      return ProfileModel.fromJson(response.data);
    }
    throw NoUserException();
  }

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
}
