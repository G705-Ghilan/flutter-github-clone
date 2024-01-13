import 'package:github_clone/src/core/typedefs.dart';
import 'package:github_clone/src/core/usecases/usecase.dart';
import 'package:github_clone/src/features/user_profile/domain/entities/profile.dart';
import 'package:github_clone/src/features/user_profile/domain/repository/user_profile_repository.dart';

class GetUserProfile extends UseCase<Profile, String> {
  final UserProfileRepository repo;

  GetUserProfile(this.repo);

  @override
  FailureOr<Profile> call(String params) async {
    return await repo.getUserProfile(params);
  }
}
