import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/users/domain/domain.dart';

class GetUsers extends UseCase<Users, UsersParams> {
  final UsersRepository repo;

  GetUsers(this.repo);

  @override
  FailureOr<Users> call(UsersParams params) async {
    return await repo.getUsers(params);
  }
}

class UsersParams {
  final String username;
  final UsersType usersType;
  final String? repository;
  final String? query;

  UsersParams({
    required this.username,
    required this.usersType,
    this.repository,
    this.query,
  });
  String get key => "$username-$repository-${usersType.name}-$query";
}

enum UsersType {
  starred("Starred"),
  following("Following"),
  followers("Followers"),
  repoWachers("Wachers"),
  repoStars("Stars"),
  repoContributors("Contributors"),
  search("Search");

  final String eName;
  const UsersType(this.eName);
}
