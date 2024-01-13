import 'package:equatable/equatable.dart';

import 'label.dart';

class Issue extends Equatable {
  final int number;
  final String title;
  final String username;
  final String userAvatarUrl;
  final DateTime createdAt;
  final List<Label> labels;
  final int comments;
  final String state;
  final String authorAssociation;
  final String? body;
  final String realUsername;
  final String repository;

  const Issue({
    required this.number,
    required this.title,
    required this.username,
    required this.userAvatarUrl,
    required this.createdAt,
    required this.labels,
    required this.comments,
    required this.state,
    required this.authorAssociation,
    required this.body,
    required this.realUsername,
    required this.repository,
  });

  factory Issue.fake() {
    return Issue(
      number: 83940,
      title: "My Issue is just test and you can keep it bro",
      username: "He's not me",
      userAvatarUrl: "",
      createdAt: DateTime.utc(2020),
      labels: const [],
      comments: 10,
      state: "Open",
      authorAssociation: "Association",
      body: "here is my problme really need it to be solved",
      realUsername: "real username",
      repository: "repository",
    );
  }

  @override
  List<Object?> get props => [
        number,
        title,
        username,
        userAvatarUrl,
        createdAt,
        labels,
        comments,
        state,
        authorAssociation,
        body,
        realUsername,
        repository,
      ];
}
