import 'package:github_clone/src/features/features.dart';

class UsersModel extends Users {
  const UsersModel({
    required super.users,
    required super.page,
    required super.hasMore,
  });

  Users toEntity() {
    return Users(
      users: <User>[...users],
      page: page,
      hasMore: hasMore,
    );
  }
}
