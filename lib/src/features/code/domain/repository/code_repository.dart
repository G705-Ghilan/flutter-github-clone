import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/features/code/domain/entities/file_info.dart';
import 'package:github_clone/src/features/code/domain/usecases/get_files.dart';

abstract class CodeRepository {
  FailureOr<List<FileInfo>> getFiles(CodeParams params);
  FailureOr<FileInfo> getCode(CodeParams params);
}
