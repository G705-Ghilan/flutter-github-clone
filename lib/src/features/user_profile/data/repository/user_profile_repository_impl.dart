import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/user_profile/user_profile.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final RemoteUserProfileDataSource remoteSource;

  UserProfileRepositoryImpl(this.remoteSource);
  final Map<String, Profile> cachedUsers = {};

  @override
  FailureOr<Profile> getUserProfile(String username) async {
    try {
      cachedUsers[username] ??= await remoteSource.getUserProfile(username);
      return Right(cachedUsers[username]!);
    } on DioException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
