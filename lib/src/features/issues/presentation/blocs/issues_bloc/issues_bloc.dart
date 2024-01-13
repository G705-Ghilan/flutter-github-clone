import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/src.dart';

part 'issues_event.dart';
part 'issues_state.dart';

class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  final GetIssues _getIssues;
  final GetMoreIssues _getMoreIssues;

  IssuesBloc(this._getIssues, this._getMoreIssues)
      : super(IssuesInitial(Issues.empty())) {
    on<LoadIssuesEvent>(getIssues);
    on<LoadMoreIssuesEvent>(getMoreIssues);
  }

  FutureOr<void> getIssues(LoadIssuesEvent event, emit) async {
    emit(LoadingIssues(state.issues));
    final response = await _getIssues(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingIssues(state.issues, failure)),
      (issues) => emit(LoadedIssues(issues)),
    );
  }

  FutureOr<void> getMoreIssues(LoadMoreIssuesEvent event, emit) async {
    emit(LoadingMoreIssues(state.issues));
    final response = await _getMoreIssues(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingIssues(state.issues, failure)),
      (issues) => emit(LoadedIssues(issues)),
    );
  }
}
