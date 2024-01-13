import 'package:dartz/dartz.dart';
import 'package:github_clone/src/src.dart';

class IssuesRepositoryImpl implements IssuesRepository {
  final RemoteIssuesDataSource remoteSource;

  IssuesRepositoryImpl(this.remoteSource);
  final Map<String, Comments> cachedComments = {};
  final Map<String, Issues> cachedIssues = {};

  @override
  FailureOr<Comments> getComments(CommentsParams params) async {
    try {
      cachedComments[params.key] ??= await remoteSource.getComments(params);
      return Right(cachedComments[params.key]!);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Issues> getIssues(IssuesParams params) async {
    try {
      cachedIssues[params.key] ??= await remoteSource.getIssues(params);
      return Right(cachedIssues[params.key]!);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Comments> getMoreComments(CommentsParams params) async {
    try {
      final current = cachedComments[params.key]!;
      if (current.hasMore) {
        final newComments = await remoteSource.getComments(
          params,
          current.page + 1,
        );
        cachedComments[params.key] = Comments(
          comments: current.comments + newComments.comments,
          page: newComments.page,
          hasMore: newComments.hasMore,
        );
        return Right(cachedComments[params.key]!);
      }
      return Right(current);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Issues> getMoreIssues(IssuesParams params) async {
    try {
      final current = cachedIssues[params.key]!;
      if (current.hasMore) {
        final newIssues = await remoteSource.getIssues(
          params,
          current.page + 1,
        );
        cachedIssues[params.key] = Issues(
          issues: current.issues + newIssues.issues,
          page: newIssues.page,
          hasMore: newIssues.hasMore,
        );
        return Right(cachedIssues[params.key]!);
      }
      return Right(current);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
