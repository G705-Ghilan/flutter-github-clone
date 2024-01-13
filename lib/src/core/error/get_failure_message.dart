import 'package:github_clone/src/core/core.dart';

String getFailureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case NetworkFailure:
      return "It seems you don't have an internet connection. Please check your internet and try again later.";
    default:
      return "An error occurred while fetching data. Please try again later.";
  }
}
