import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String login;
  final int id;
  final String avatarUrl;
  final String name;
  final String? blog;
  final String? location;
  final String? bio;
  final String? email;
  final String? twitterUsername;
  final DateTime createdAt;
  final int repositories;
  final int followers;
  final int following;

  const Profile({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.name,
    required this.blog,
    required this.location,
    required this.bio,
    required this.email,
    required this.createdAt,
    required this.twitterUsername,
    required this.repositories,
    required this.followers,
    required this.following,
  });

  factory Profile.fake() {
    return Profile(
      login: "username",
      id: 0,
      avatarUrl: "",
      name: "Guthub user",
      blog: "https://example.com",
      location: null,
      bio: "Hello this is a simple bio",
      email: null,
      createdAt: DateTime.utc(2020),
      twitterUsername: null,
      repositories: 2003,
      followers: 20,
      following: 0,
    );
  }

  @override
  List<Object?> get props => [
        login,
        id,
        avatarUrl,
        name,
        blog,
        location,
        bio,
        repositories,
        followers,
        following,
      ];
}
