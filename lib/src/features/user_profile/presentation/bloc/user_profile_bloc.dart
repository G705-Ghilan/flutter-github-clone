import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/features.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserProfile _getUserProfile;
  final GetPopularRepos _getPopularRepos;

  UserProfileBloc(this._getUserProfile, this._getPopularRepos)
      : super(UserProfileInitial()) {
    on<GetUserProfileEvent>(getUserProfile);
    on<GetPopularReposEvent>(getPopularRepos);
  }

  FutureOr<void> getUserProfile(GetUserProfileEvent event, emit) async {
    emit(LoadingProfile());
    final response = await _getUserProfile(event.username);
    response.fold(
      (failure) {
        emit(ErrorloadingProfile(failure));
        emit(EmptyPopular());
      },
      (profile) async {
        emit(LoadedProfile(profile: profile));
        if (profile.repositories > 0) {
          add(GetPopularReposEvent(profile.login));
        } else {
          emit(EmptyPopular());
        }
      },
    );
  }

  FutureOr<void> getPopularRepos(GetPopularReposEvent event, emit) async {
    emit(LoadingPopular());
    final response = await _getPopularRepos(event.username);
    response.fold(
      (failure) => emit(ErrorLoadingPopular(failure)),
      (repos) => emit(LoadedPopualr(repos: repos)),
    );
  }
}
