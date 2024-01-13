import 'package:github_clone/src/features/repos/domain/entities/repo_info.dart';

class RepoInfoModel extends RepoInfo {
  const RepoInfoModel({
    required super.name,
    required super.stars,
    required super.description,
    required super.ownerAvatarUrl,
    required super.ownerName,
    required super.language,
    required super.visibility,
    required super.homePage,
    required super.wachers,
    required super.forks,
    required super.issues,
    required super.createdAt,
  });

  factory RepoInfoModel.fromJson(Map<String, dynamic> json) {
    return RepoInfoModel(
      name: json["name"],
      stars: json["stargazers_count"],
      description: json["description"],
      ownerAvatarUrl: json["owner"]["avatar_url"],
      ownerName: json["owner"]["login"],
      language: json["language"],
      visibility: json["visibility"],
      homePage: json["homepage"],
      wachers: json["watchers_count"],
      forks: json["forks_count"],
      issues: json["open_issues_count"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}
