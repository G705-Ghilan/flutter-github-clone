import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/src.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetComments _getComments;
  final GetMoreComments _getMoreComments;

  CommentsBloc(this._getComments, this._getMoreComments)
      : super(CommentsInitial(Comments.empty())) {
    on<LoadCommentsEvent>(getComments);
    on<LoadMoreCommentsEvent>(getMoreComments);
  }

  FutureOr<void> getComments(LoadCommentsEvent event, emit) async {
    emit(LoadingComments(state.comments));
    final response = await _getComments(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingComments(state.comments, failure)),
      (comments) => emit(LoadedComments(comments)),
    );
  }

  FutureOr<void> getMoreComments(LoadMoreCommentsEvent event, emit) async {
    emit(LoadingMoreComments(state.comments));
    final response = await _getMoreComments(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingComments(state.comments, failure)),
      (comments) => emit(LoadedComments(comments)),
    );
  }
}
