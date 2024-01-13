import 'package:github_clone/src/src.dart';

abstract class RemoteIssuesDataSource {
  Future<Issues> getIssues(IssuesParams params, [int page = 1]);
  Future<Comments> getComments(CommentsParams params, [int page = 1]);
}

class RemoteIssuesDataSourceImpl implements RemoteIssuesDataSource {
  final DioClient client;

  RemoteIssuesDataSourceImpl(this.client);

  @override
  Future<Comments> getComments(CommentsParams params, [int page = 1]) async {
    final response = await client.dio.get(
      "/repos/${params.username}/${params.repository}/issues/${params.number}/comments",
      options: await client.refreshIfConnectedOption(),
      queryParameters: {"page": page},
    );
    if ([200, 304].contains(response.statusCode)) {
      final comments = [
        for (Map<String, dynamic> json in response.data)
          CommentModel.fromJson(json)
      ];
      return Comments(
        comments: comments,
        page: page,
        hasMore: comments.length == 30,
      );
    }
    throw NoUserException();
  }

  @override
  Future<Issues> getIssues(IssuesParams params, [int page = 1]) async {
    final response = await client.dio.get(
      params.query != null
          ? "/search/issues?q=${params.query}"
          : "/repos/${params.username}/${params.repository}/issues",
      options: await client.refreshIfConnectedOption(),
      queryParameters: {"page": page},
    );
    if ([200, 304].contains(response.statusCode)) {
      final issues = [
        for (Map<String, dynamic> json
            in params.query != null ? response.data["items"] : response.data)
          IssueModel.fromJson(json)
      ];
      return Issues(
        issues: issues,
        page: page,
        hasMore: issues.length == 30,
      );
    }
    throw NoUserException();
  }
}
