part of "features.dart";

void codeFeature() {
  // data source
  sl.registerSingleton<RemoteCodeDataSource>(RemoteCodeDataSourceImpl(sl()));

  // repository
  sl.registerSingleton<CodeRepository>(CodeRepositoryImpl(sl()));

  // usecases
  sl.registerSingleton<GetFiles>(GetFiles(sl()));
  sl.registerSingleton<GetCode>(GetCode(sl()));

  // bloc
  sl.registerFactory<CodeBloc>(() => CodeBloc(sl(), sl()));
}
