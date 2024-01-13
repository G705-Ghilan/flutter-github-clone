import 'package:equatable/equatable.dart';

class RepoInfo extends Equatable {
  final String name;
  final int stars;
  final String? description;
  final String ownerAvatarUrl;
  final String ownerName;
  final String? language;
  final String visibility;
  final String? homePage;
  final int wachers;
  final int forks;
  final int issues;
  final DateTime createdAt;

  factory RepoInfo.fake() {
    return RepoInfo(
      name: "The-Repository name",
      stars: 3000,
      description: "Some text for description",
      ownerAvatarUrl: "",
      ownerName: "Username",
      language: null,
      visibility: "public",
      homePage: null,
      wachers: 0,
      forks: 10,
      issues: 2,
      createdAt: DateTime.utc(2022),
    );
  }

  const RepoInfo({
    required this.name,
    required this.stars,
    required this.description,
    required this.ownerAvatarUrl,
    required this.ownerName,
    required this.language,
    required this.visibility,
    required this.homePage,
    required this.wachers,
    required this.forks,
    required this.issues,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        name,
        stars,
        description,
        ownerAvatarUrl,
        ownerName,
        language,
        visibility,
        homePage,
        wachers,
        forks,
        issues,
        createdAt,
      ];
}
