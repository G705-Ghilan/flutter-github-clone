import 'package:github_clone/src/features/issues/issues.dart';

class IssueModel extends Issue {
  const IssueModel({
    required super.number,
    required super.title,
    required super.username,
    required super.userAvatarUrl,
    required super.createdAt,
    required super.labels,
    required super.comments,
    required super.state,
    required super.authorAssociation,
    required super.body,
    required super.realUsername,
    required super.repository,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    List<String> repoUrl = (json["repository_url"] as String).split("/");
    repoUrl = repoUrl.sublist(repoUrl.length - 2);
    return IssueModel(
      number: json["number"],
      title: json["title"],
      username: json["user"]["login"],
      userAvatarUrl: json["user"]["avatar_url"],
      createdAt: DateTime.parse(json["created_at"]),
      labels: [
        for (Map<String, dynamic> label in json["labels"])
          LabelModel.fromJson(label)
      ],
      comments: json["comments"],
      state: json["state"],
      authorAssociation: json["author_association"],
      body: json["body"],
      realUsername: repoUrl.first,
      repository: repoUrl.last,
    );
  }
}
