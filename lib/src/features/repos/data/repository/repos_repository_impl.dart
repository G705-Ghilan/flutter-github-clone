import 'package:dartz/dartz.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/repos/data/data.dart';
import 'package:github_clone/src/features/repos/domain/domain.dart';

class ReposRepositoryImpl implements ReposRepository {
  final RemoteReposDataSource remoteSource;

  ReposRepositoryImpl(this.remoteSource);
  final Map<String, Repos> cachedRepos = {};
  final Map<String, List<RepoInfoModel>> cachedPopular = {};

  @override
  FailureOr<Repos> getMoreRepos(ReposParams params) async {
    try {
      final current = cachedRepos[params.key]!;
      if (current.hasMore) {
        final newRepos = await remoteSource.getRepos(
          params,
          current.page + 1,
        );
        cachedRepos[params.key] = Repos(
          repos: current.repos + newRepos.repos,
          page: newRepos.page,
          hasMore: newRepos.hasMore,
        );
        return Right(cachedRepos[params.key]!);
      }
      return Right(current);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<List<RepoInfo>> getPopularRepos(String username) async {
    try {
      cachedPopular[username] ??= await remoteSource.getPopularRepos(username);
      return Right(cachedPopular[username]!);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Repos> getRepos(ReposParams params) async {
    try {
      cachedRepos[params.key] ??= await remoteSource.getRepos(params);
      return Right(cachedRepos[params.key]!);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
