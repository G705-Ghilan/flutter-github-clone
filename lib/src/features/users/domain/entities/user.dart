import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String avatarUrl;
  final int? contributions;

  const User({
    required this.name,
    required this.avatarUrl,
    this.contributions,
  });

  factory User.fake() {
    return const User(
      name: "Username",
      avatarUrl: "",
    );
  }

  @override
  List<Object?> get props => [name, avatarUrl, contributions];
}
