import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/repos/domain/entities/repos.dart';
import 'package:github_clone/src/features/repos/domain/repository/repos_repository.dart';

class GetRepos extends UseCase<Repos, ReposParams> {
  final ReposRepository repo;

  GetRepos(this.repo);

  @override
  FailureOr<Repos> call(ReposParams params) async {
    return await repo.getRepos(params);
  }
}

class ReposParams {
  final String username;
  final ReposType reposType;
  final String? repository;
  final String? query;

  ReposParams({
    required this.username,
    required this.reposType,
    this.repository,
    this.query,
  });

  String get key => "$username-${reposType.name}-$repository-$query";
}

enum ReposType {
  userStarred("Starred repositories"),
  userRepos("Repositories"),
  repoForks("Forks"),
  search("Search");

  final String eName;
  const ReposType(this.eName);
}
