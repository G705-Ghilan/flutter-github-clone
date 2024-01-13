part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfileEvent extends UserProfileEvent {
  final String username;

  const GetUserProfileEvent(this.username);
}

class GetPopularReposEvent extends UserProfileEvent {
  final String username;

  const GetPopularReposEvent(this.username);
}
