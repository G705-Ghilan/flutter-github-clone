import 'package:github_clone/src/src.dart';

class GetIssues extends UseCase<Issues, IssuesParams> {
  final IssuesRepository repo;

  GetIssues(this.repo);

  @override
  FailureOr<Issues> call(IssuesParams params) async {
    return await repo.getIssues(params);
  }
}

class IssuesParams {
  final String username;
  final String repository;
  final String? query;

  IssuesParams({required this.username, required this.repository, this.query});
  String get key => "$username-$repository-$query";
}
