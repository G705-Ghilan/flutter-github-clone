import 'package:equatable/equatable.dart';
import 'user.dart';

class Users extends Equatable {
  final List<User> users;
  final int page;
  final bool hasMore;

  const Users({
    required this.users,
    required this.page,
    required this.hasMore,
  });
  factory Users.empty() {
    return const Users(users: [], page: 0, hasMore: true);
  }

  @override
  List<Object?> get props => [users, page, hasMore];
}
