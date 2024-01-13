import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone/src/src.dart';

part 'code_event.dart';
part 'code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {
  final GetFiles _getFiles;
  final GetCode _getCode;

  CodeBloc(this._getFiles, this._getCode) : super(CodeInitial()) {
    on<LoadFilesEvent>(getFiles);
    on<LoadCodeEvent>(getCode);
  }

  FutureOr<void> getFiles(LoadFilesEvent event, emit) async {
    emit(LoadingFiles());
    final response = await _getFiles(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingFiles(failure)),
      (files) => emit(LoadedFiles(files)),
    );
  }

  FutureOr<void> getCode(LoadCodeEvent event, emit) async {
    emit(LoadingFiles());
    final response = await _getCode(event.params);
    response.fold(
      (failure) => emit(ErrorLoadingFiles(failure)),
      (files) => emit(LoadedFiles([files])),
    );
  }
}
