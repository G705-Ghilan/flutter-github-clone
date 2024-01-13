part of "features.dart";

void userProfileFeature() {
  // data source
  sl.registerSingleton<RemoteUserProfileDataSource>(
    RemoteUserProfileDataSourceImpl(sl()),
  );

  // repository
  sl.registerSingleton<UserProfileRepository>(UserProfileRepositoryImpl(sl()));

  // usecases
  sl.registerSingleton<GetUserProfile>(GetUserProfile(sl()));

  // bloc
  sl.registerFactory<UserProfileBloc>(() => UserProfileBloc(sl(), sl()));
}
