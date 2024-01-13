import 'package:github_clone/src/src.dart';

class GetMoreComments extends UseCase<Comments, CommentsParams> {
  final IssuesRepository repo;

  GetMoreComments(this.repo);

  @override
  FailureOr<Comments> call(CommentsParams params) async {
    return await repo.getComments(params);
  }
}
