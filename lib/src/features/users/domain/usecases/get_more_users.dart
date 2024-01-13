import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/users/domain/domain.dart';

class GetMoreUsers extends UseCase<Users, UsersParams> {
  final UsersRepository repo;

  GetMoreUsers(this.repo);

  @override
  FailureOr<Users> call(UsersParams params) async {
    return await repo.getMoreUsers(params);
  }
}
