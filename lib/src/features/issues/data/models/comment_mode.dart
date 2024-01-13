import 'package:github_clone/src/features/issues/domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.username,
    required super.userAvatarUrl,
    required super.createdAt,
    required super.authorAssociation,
    required super.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      username: json["user"]["login"],
      userAvatarUrl: json["user"]["avatar_url"],
      createdAt: DateTime.parse(json["created_at"]),
      authorAssociation: json["author_association"],
      body: json["body"],
    );
  }
}
