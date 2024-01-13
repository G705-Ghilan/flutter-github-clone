import 'package:github_clone/src/src.dart';

abstract class IssuesRepository {
  FailureOr<Issues> getIssues(IssuesParams params);
  FailureOr<Issues> getMoreIssues(IssuesParams params);
  FailureOr<Comments> getComments(CommentsParams params);
  FailureOr<Comments> getMoreComments(CommentsParams params);
}
