part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsersEvent extends UsersEvent {
  final UsersParams params;

  const LoadUsersEvent({required this.params});
  @override
  List<Object> get props => [params];
}

class LoadMoreUsersEvent extends UsersEvent {
  final UsersParams params;

  const LoadMoreUsersEvent({required this.params});
  @override
  List<Object> get props => [params];
}
