import 'package:dartz/dartz.dart';
import 'package:github_clone/src/src.dart';

class CodeRepositoryImpl implements CodeRepository {
  final RemoteCodeDataSource remoteSource;

  CodeRepositoryImpl(this.remoteSource);
  final Map<String, List<FileInfoModel>> cachedFiles = {};
  final Map<String, FileInfoModel> cachedCodes = {};

  @override
  FailureOr<FileInfo> getCode(CodeParams params) async {
    try {
      cachedCodes[params.key] ??= await remoteSource.getCode(params);
      return Right(cachedCodes[params.key]!);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<List<FileInfo>> getFiles(CodeParams params) async {
    try {
      cachedFiles[params.key] ??= await remoteSource.getFiles(params);
      return Right(cachedFiles[params.key]!);
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
