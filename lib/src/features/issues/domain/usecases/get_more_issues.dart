import 'package:github_clone/src/src.dart';

class GetMoreIssues extends UseCase<Issues, IssuesParams> {
  final IssuesRepository repo;

  GetMoreIssues(this.repo);

  @override
  FailureOr<Issues> call(IssuesParams params) async {
    return await repo.getMoreIssues(params);
  }
}