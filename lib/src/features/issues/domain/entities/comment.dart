import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String username;
  final String userAvatarUrl;
  final DateTime createdAt;
  final String authorAssociation;
  final String body;

  const Comment({
    required this.username,
    required this.userAvatarUrl,
    required this.createdAt,
    required this.authorAssociation,
    required this.body,
  });

  factory Comment.fake() {
    return Comment(
      username: "G705-Ghilan",
      userAvatarUrl: "",
      createdAt: DateTime.utc(2020),
      authorAssociation: "None is Here",
      body: "Some text here\nto show message",
    );
  }

  @override
  List<Object?> get props => [
        username,
        userAvatarUrl,
        createdAt,
        authorAssociation,
        body,
      ];
}
