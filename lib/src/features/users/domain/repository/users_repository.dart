import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/users/domain/domain.dart';

abstract class UsersRepository {
  FailureOr<Users> getUsers(UsersParams params);
  FailureOr<Users> getMoreUsers(UsersParams params);
}
