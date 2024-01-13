part of "features.dart";

void issuesFeature() {
  // data source
  sl.registerSingleton<RemoteIssuesDataSource>(
    RemoteIssuesDataSourceImpl(sl()),
  );

  // repository
  sl.registerSingleton<IssuesRepository>(IssuesRepositoryImpl(sl()));

  // usecases
  sl.registerSingleton<GetIssues>(GetIssues(sl()));
  sl.registerSingleton<GetMoreIssues>(GetMoreIssues(sl()));
  sl.registerSingleton<GetComments>(GetComments(sl()));
  sl.registerSingleton<GetMoreComments>(GetMoreComments(sl()));

  // blocs
  sl.registerFactory<IssuesBloc>(() => IssuesBloc(sl(), sl()));
  sl.registerFactory<CommentsBloc>(() => CommentsBloc(sl(), sl()));
}
