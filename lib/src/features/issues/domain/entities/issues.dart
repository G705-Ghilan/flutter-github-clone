import 'package:equatable/equatable.dart';
import 'issue.dart';

class Issues extends Equatable {
  final List<Issue> issues;
  final int page;
  final bool hasMore;

  const Issues({
    required this.issues,
    required this.page,
    required this.hasMore,
  });

  factory Issues.empty() => const Issues(issues: [], page: 0, hasMore: true);

  @override
  List<Object?> get props => [
        issues,
        page,
        hasMore,
      ];
}
