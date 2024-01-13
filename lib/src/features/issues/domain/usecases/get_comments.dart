import 'package:github_clone/src/src.dart';

class GetComments extends UseCase<Comments, CommentsParams> {
  final IssuesRepository repo;

  GetComments(this.repo);

  @override
  FailureOr<Comments> call(CommentsParams params) async {
    return await repo.getComments(params);
  }
}

class CommentsParams {
  final String username;
  final String repository;
  final String number;

  CommentsParams({
    required this.username,
    required this.repository,
    required this.number,
  });

  String get key => "$username-$repository-$number";
}
