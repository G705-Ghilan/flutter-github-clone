part of "features.dart";

void reposFeature() {
  // data source
  sl.registerSingleton<RemoteReposDataSource>(RemoteReposDataSourceImpl(sl()));

  // repository
  sl.registerSingleton<ReposRepository>(ReposRepositoryImpl(sl()));

  // usecases
  sl.registerSingleton<GetRepos>(GetRepos(sl()));
  sl.registerSingleton<GetMoreRepos>(GetMoreRepos(sl()));
  sl.registerSingleton<GetPopularRepos>(GetPopularRepos(sl()));

  // bloc
  sl.registerFactory<ReposBloc>(() => ReposBloc(sl(), sl()));
}
