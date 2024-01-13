import 'package:equatable/equatable.dart';

import 'repo_info.dart';

class Repos extends Equatable {
  final List<RepoInfo> repos;
  final int page;
  final bool hasMore;

  const Repos({
    required this.repos,
    required this.page,
    required this.hasMore,
  });
  factory Repos.empty() {
    return const Repos(repos: [], page: 0, hasMore: true);
  }

  @override
  List<Object?> get props => [repos, page, hasMore];
}
