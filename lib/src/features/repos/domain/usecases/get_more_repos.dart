import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/repos/domain/entities/repos.dart';
import 'package:github_clone/src/features/repos/domain/repository/repos_repository.dart';
import 'package:github_clone/src/features/repos/domain/usecases/get_repos.dart';

class GetMoreRepos extends UseCase<Repos, ReposParams> {
  final ReposRepository repo;

   GetMoreRepos(this.repo);

  @override
  FailureOr<Repos> call(ReposParams params) async {
    return await repo.getMoreRepos(params);
  }
}
