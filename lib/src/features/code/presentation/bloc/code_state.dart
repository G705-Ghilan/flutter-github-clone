part of 'code_bloc.dart';

abstract class CodeState extends Equatable {
  const CodeState();

  @override
  List<Object> get props => [];
}

class CodeInitial extends CodeState {}

class LoadingFiles extends CodeState {}

class LoadedFiles extends CodeState {
  final List<FileInfo> files;

  const LoadedFiles(this.files);
  @override
  List<Object> get props => [files];
}

class ErrorLoadingFiles extends CodeState {
  final Failure failure;

  const ErrorLoadingFiles(this.failure);
  @override
  List<Object> get props => [failure];
}
