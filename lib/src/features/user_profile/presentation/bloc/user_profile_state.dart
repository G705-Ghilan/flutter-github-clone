part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

abstract class ProfileCardState extends UserProfileState {
  const ProfileCardState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends ProfileCardState {}

class LoadingProfile extends ProfileCardState {}

class LoadedProfile extends ProfileCardState {
  final Profile profile;

  const LoadedProfile({required this.profile});
  @override
  List<Object> get props => [profile];
}

class ErrorloadingProfile extends ProfileCardState {
  final Failure failure;

  const ErrorloadingProfile(this.failure);
  @override
  List<Object> get props => [failure];
}

abstract class PopularState extends UserProfileState {
  const PopularState();

  @override
  List<Object> get props => [];
}

class LoadingPopular extends PopularState {}

class EmptyPopular extends PopularState {}

class LoadedPopualr extends PopularState {
  final List<RepoInfo> repos;

  const LoadedPopualr({required this.repos});
  @override
  List<Object> get props => [repos];
}

class ErrorLoadingPopular extends PopularState {
  final Failure failure;

  const ErrorLoadingPopular(this.failure);
  @override
  List<Object> get props => [failure];
}
