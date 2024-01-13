import 'package:github_clone/src/src.dart';

class GetCode extends UseCase<FileInfo, CodeParams> {
  final CodeRepository repo;

  GetCode(this.repo);
  @override
  FailureOr<FileInfo> call(CodeParams params) async {
    return await repo.getCode(params);
  }
}
