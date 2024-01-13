import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/repos/domain/entities/repos.dart';
import 'package:github_clone/src/features/repos/domain/usecases/get_repos.dart';
import 'package:github_clone/src/features/user_profile/user_profile.dart';

abstract class ReposRepository {
  FailureOr<Repos> getRepos(ReposParams params);
  FailureOr<Repos> getMoreRepos(ReposParams params);
  FailureOr<List<RepoInfo>> getPopularRepos(String username);
}
