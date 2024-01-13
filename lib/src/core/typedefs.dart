import 'package:dartz/dartz.dart';
import 'package:github_clone/src/core/error/failures.dart';

typedef FailureOr<T> = Future<Either<Failure, T>>;
