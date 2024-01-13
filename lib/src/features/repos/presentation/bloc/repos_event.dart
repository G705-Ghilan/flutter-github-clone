part of 'repos_bloc.dart';

abstract class ReposEvent extends Equatable {
  const ReposEvent();

  @override
  List<Object> get props => [];
}

class LoadReposEvent extends ReposEvent {
  final ReposParams params;

  const LoadReposEvent({required this.params});
  @override
  List<Object> get props => [params];
}

class LoadMoreReposEvent extends ReposEvent {
  final ReposParams params;

  const LoadMoreReposEvent({required this.params});
  @override
  List<Object> get props => [params];
}
