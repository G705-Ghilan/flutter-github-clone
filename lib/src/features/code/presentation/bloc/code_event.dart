part of 'code_bloc.dart';

abstract class CodeEvent extends Equatable {
  const CodeEvent();

  @override
  List<Object> get props => [];
}

class LoadFilesEvent extends CodeEvent {
  final CodeParams params;

  const LoadFilesEvent(this.params);
  @override
  List<Object> get props => [params];
}

class LoadCodeEvent extends CodeEvent {
  final CodeParams params;

  const LoadCodeEvent(this.params);
  @override
  List<Object> get props => [params];
}
