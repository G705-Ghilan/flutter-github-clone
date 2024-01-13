import 'package:equatable/equatable.dart';
import 'comment.dart';

class Comments extends Equatable {
  final List<Comment> comments;
  final int page;
  final bool hasMore;

  const Comments({
    required this.comments,
    required this.page,
    required this.hasMore,
  });

  factory Comments.empty() => const Comments(comments: [], page: 0, hasMore: true);

  @override
  List<Object?> get props => [
        comments,
        page,
        hasMore,
      ];
}
