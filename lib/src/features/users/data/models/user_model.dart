import 'package:github_clone/src/features/features.dart';

class UserModel extends User {
  const UserModel({
    required super.name,
    required super.avatarUrl,
    super.contributions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["login"],
      avatarUrl: json["avatar_url"],
      contributions: json["contributions"],
    );
  }

  User toEntity() {
    return User(name: name, avatarUrl: avatarUrl);
  }
}
