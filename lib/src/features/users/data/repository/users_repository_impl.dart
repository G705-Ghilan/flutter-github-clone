import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';

class UsersRepositoryImpl implements UsersRepository {
  final RemoteUsersDataSource remoteSource;

  UsersRepositoryImpl(this.remoteSource);

  final Map<String, UsersModel> cached = {};

  @override
  FailureOr<Users> getUsers(UsersParams params) async {
    try {
      cached[params.key] ??= await remoteSource.getUsers(params);
      return Right(cached[params.key]!.toEntity());
    } on DioException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<Users> getMoreUsers(UsersParams params) async {
    try {
      final current = cached[params.key]!;
      if (current.hasMore) {
        final newFollowers = await remoteSource.getUsers(
          params,
          current.page + 1,
        );
        cached[params.key] = UsersModel(
          users: current.users + newFollowers.users,
          page: newFollowers.page,
          hasMore: newFollowers.hasMore,
        );
        return Right(cached[params.key]!.toEntity());
      }
      return Right(current);
    } on DioException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
