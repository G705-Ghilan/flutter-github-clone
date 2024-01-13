import 'package:github_clone/src/src.dart';

class GetFiles extends UseCase<List<FileInfo>, CodeParams> {
  final CodeRepository repo;

  GetFiles(this.repo);
  @override
  FailureOr<List<FileInfo>> call(CodeParams params) async {
    return await repo.getFiles(params);
  }
}

class CodeParams {
  final String username;
  final String repository;
  final String path;

  CodeParams({
    required this.username,
    required this.repository,
    required this.path,
  });
  String get key => "$username-$repository-$path";
}
