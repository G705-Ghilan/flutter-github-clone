import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/repos/domain/domain.dart';

part 'repos_event.dart';
part 'repos_state.dart';

class ReposBloc extends Bloc<ReposEvent, ReposState> {
  final GetRepos _getRepos;
  final GetMoreRepos _getMoreRepos;
  
  ReposBloc(this._getRepos, this._getMoreRepos)
      : super(ReposInitial(Repos.empty())) {
    on<LoadReposEvent>(loadRepos);
    on<LoadMoreReposEvent>(loadMoreRepos);
  }

  FutureOr<void> loadRepos(LoadReposEvent event, emit) async {
    emit(LoadingRepos(state.repos));
    final response = await _getRepos(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingRepos(Repos.empty(), failure)),
      (repos) => emit(LoadedRepos(repos)),
    );
  }

  FutureOr<void> loadMoreRepos(LoadMoreReposEvent event, emit) async {
    emit(LoadingMoreRepos(state.repos));
    final response = await _getMoreRepos(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingRepos(state.repos, failure)),
      (repos) => emit(LoadedRepos(repos)),
    );
  }
}
