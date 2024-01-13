part of 'issues_bloc.dart';

abstract class IssuesState extends Equatable {
  final Issues issues;
  const IssuesState(this.issues);

  @override
  List<Object> get props => [];
}

class IssuesInitial extends IssuesState {
  const IssuesInitial(super.issues);
}

class LoadingIssues extends IssuesState {
  const LoadingIssues(super.issues);
}

class LoadingMoreIssues extends IssuesState {
  const LoadingMoreIssues(super.issues);
}

class LoadedIssues extends IssuesState {
  const LoadedIssues(super.issues);
}

class ErrorLoadingIssues extends IssuesState {
  final Failure failure;

  const ErrorLoadingIssues(super.issues, this.failure);
}
