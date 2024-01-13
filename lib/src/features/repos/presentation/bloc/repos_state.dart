part of 'repos_bloc.dart';

abstract class ReposState extends Equatable {
  final Repos repos;
  const ReposState(this.repos);

  @override
  List<Object> get props => [];
}

class ReposInitial extends ReposState {
  const ReposInitial(super.repos);
}

class LoadingRepos extends ReposState {
  const LoadingRepos(super.repos);
}

class LoadingMoreRepos extends ReposState {
  const LoadingMoreRepos(super.repos);
}

class LoadedRepos extends ReposState {
  const LoadedRepos(super.repos);
}


class ErrorLoadingRepos extends ReposState {
  final Failure failure;

  const ErrorLoadingRepos(super.repos, this.failure);
}
