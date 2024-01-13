import 'package:github_clone/src/features/user_profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.login,
    required super.id,
    required super.avatarUrl,
    required super.name,
    required super.blog,
    required super.location,
    required super.bio,
    required super.email,
    required super.createdAt,
    required super.twitterUsername,
    required super.repositories,
    required super.followers,
    required super.following,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      login: json["login"],
      id: json["id"],
      avatarUrl: json["avatar_url"],
      name: json["name"] ?? json["login"],
      blog: json["blog"],
      location: json["location"],
      bio: json["bio"],
      twitterUsername: json["twitter_username"],
      email: json["email"],
      createdAt: DateTime.parse(json["created_at"]),
      repositories: json["public_repos"],
      followers: json["followers"],
      following: json["following"],
    );
  }
}
