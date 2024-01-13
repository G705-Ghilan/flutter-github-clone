import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/repos/domain/repository/repos_repository.dart';
import 'package:github_clone/src/features/user_profile/user_profile.dart';

class GetPopularRepos extends UseCase<List<RepoInfo>, String> {
  final ReposRepository repo;

   GetPopularRepos(this.repo);

  @override
  FailureOr<List<RepoInfo>> call(String params) async {
    return await repo.getPopularRepos(params);
  }
}
