part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  final Users users;

  const UsersState(this.users);

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {
  const UsersInitial(super.users);
}

class LoadingUsers extends UsersState {
  const LoadingUsers(super.users);
}

class LoadingMoreFollow extends UsersState {
  const LoadingMoreFollow(super.users);
}

class LoadedUsers extends UsersState {
  const LoadedUsers(super.users);
}

class ErrorLoadingUsers extends UsersState {
  final Failure failure;

  const ErrorLoadingUsers(super.users, this.failure);
}
