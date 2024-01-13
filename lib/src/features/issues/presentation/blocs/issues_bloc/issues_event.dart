part of 'issues_bloc.dart';

abstract class IssuesEvent extends Equatable {
  const IssuesEvent();

  @override
  List<Object> get props => [];
}

class LoadIssuesEvent extends IssuesEvent {
  final IssuesParams params;

  const LoadIssuesEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class LoadMoreIssuesEvent extends IssuesEvent {
  final IssuesParams params;

  const LoadMoreIssuesEvent({required this.params});

  @override
  List<Object> get props => [params];
}
