import 'package:github_clone/src/core/typedefs.dart';
import 'package:github_clone/src/features/user_profile/domain/entities/profile.dart';

abstract class UserProfileRepository {
  FailureOr<Profile> getUserProfile(String username);
}
