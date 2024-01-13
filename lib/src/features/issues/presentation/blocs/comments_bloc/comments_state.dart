part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  final Comments comments;
  const CommentsState(this.comments);

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {
  const CommentsInitial(super.comments);
}

class LoadingComments extends CommentsState {
  const LoadingComments(super.comments);
}

class LoadingMoreComments extends CommentsState {
  const LoadingMoreComments(super.comments);
}

class LoadedComments extends CommentsState {
  const LoadedComments(super.comments);
}

class ErrorLoadingComments extends CommentsState {
  final Failure failure;

  const ErrorLoadingComments(super.comments, this.failure);
}
