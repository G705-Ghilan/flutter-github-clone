part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentsEvent extends CommentsEvent {
  final CommentsParams params;

  const LoadCommentsEvent({required this.params});
  @override
  List<Object> get props => [params];
}

class LoadMoreCommentsEvent extends CommentsEvent {
  final CommentsParams params;

  const LoadMoreCommentsEvent({required this.params});
  @override
  List<Object> get props => [params];
}
