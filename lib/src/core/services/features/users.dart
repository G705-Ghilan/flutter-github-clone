part of "features.dart";

void usersFeature() {
  // data source
  sl.registerSingleton<RemoteUsersDataSource>(RemoteUsersDataSourceImpl(sl()));

  // repository
  sl.registerSingleton<UsersRepository>(UsersRepositoryImpl(sl()));

  // usecases
  sl.registerSingleton<GetUsers>(GetUsers(sl()));
  sl.registerSingleton<GetMoreUsers>(GetMoreUsers(sl()));

  // bloc
  sl.registerFactory<UsersBloc>(() => UsersBloc(sl(), sl()));
}
