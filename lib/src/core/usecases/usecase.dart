import 'package:github_clone/src/core/typedefs.dart';

abstract class UseCase<Type, Params> {
  UseCase();
  FailureOr<Type> call(Params params);
}

abstract class UseCaseNoParams<Type> {
  FailureOr<Type> call();
}
