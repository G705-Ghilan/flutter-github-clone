import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/users/domain/domain.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsers _getUsers;
  final GetMoreUsers _getMoreUsers;

  UsersBloc(this._getUsers, this._getMoreUsers)
      : super(UsersInitial(Users.empty())) {
    on<LoadUsersEvent>(getUsers);
    on<LoadMoreUsersEvent>(getMoreUsers);
  }

  FutureOr<void> getUsers(LoadUsersEvent event, emit) async {
    emit(LoadingUsers(state.users));
    final response = await _getUsers(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingUsers(state.users, failure)),
      (users) => emit(LoadedUsers(users)),
    );
  }

  FutureOr<void> getMoreUsers(LoadMoreUsersEvent event, emit) async {
    emit(LoadingMoreFollow(state.users));
    final response = await _getMoreUsers(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingUsers(state.users, failure)),
      (users) => emit(LoadedUsers(users)),
    );
  }
}
