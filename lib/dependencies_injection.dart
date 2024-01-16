import 'package:get_it/get_it.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:github_clone/src/features/features.dart';

final GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  // Shared preferences
  final prefs = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerSingleton<SharedPreferences>(prefs);
  }

  if (prefs.token == null) return;

  // Dio
  final DioClient dioClient = DioClient();
  await dioClient.initDioClient(prefs.token!);
  sl.registerSingleton<DioClient>(dioClient);

  _dataSources();
  _repositories();
  _useCases();
  _blocs();
}

/// Register dataSources
void _dataSources() {
  sl.registerSingleton<RemoteUserProfileDataSource>(
    RemoteUserProfileDataSourceImpl(sl()),
  );
  sl.registerSingleton<RemoteUsersDataSource>(
    RemoteUsersDataSourceImpl(sl()),
  );
  sl.registerSingleton<RemoteReposDataSource>(
    RemoteReposDataSourceImpl(sl()),
  );
  sl.registerSingleton<RemoteIssuesDataSource>(
    RemoteIssuesDataSourceImpl(sl()),
  );
  sl.registerSingleton<RemoteCodeDataSource>(
    RemoteCodeDataSourceImpl(sl()),
  );
}

/// Register repositories
void _repositories() {
  sl.registerSingleton<UserProfileRepository>(UserProfileRepositoryImpl(sl()));
  sl.registerSingleton<UsersRepository>(UsersRepositoryImpl(sl()));
  sl.registerSingleton<ReposRepository>(ReposRepositoryImpl(sl()));
  sl.registerSingleton<IssuesRepository>(IssuesRepositoryImpl(sl()));
  sl.registerSingleton<CodeRepository>(CodeRepositoryImpl(sl()));
}

/// Register useCases
void _useCases() {
  /// Profile
  sl.registerSingleton<GetUserProfile>(GetUserProfile(sl()));

  /// Users 
  sl.registerSingleton<GetUsers>(GetUsers(sl()));
  sl.registerSingleton<GetMoreUsers>(GetMoreUsers(sl()));

  /// Repositories
  sl.registerSingleton<GetRepos>(GetRepos(sl()));
  sl.registerSingleton<GetMoreRepos>(GetMoreRepos(sl()));
  sl.registerSingleton<GetPopularRepos>(GetPopularRepos(sl()));

  /// Issues
  sl.registerSingleton<GetIssues>(GetIssues(sl()));
  sl.registerSingleton<GetMoreIssues>(GetMoreIssues(sl()));
  sl.registerSingleton<GetComments>(GetComments(sl()));
  sl.registerSingleton<GetMoreComments>(GetMoreComments(sl()));

  /// Code
  sl.registerSingleton<GetFiles>(GetFiles(sl()));
  sl.registerSingleton<GetCode>(GetCode(sl()));
}

/// Register blocs
void _blocs() {
  sl.registerFactory<UserProfileBloc>(() => UserProfileBloc(sl(), sl()));
  sl.registerFactory<UsersBloc>(() => UsersBloc(sl(), sl()));
  sl.registerFactory<ReposBloc>(() => ReposBloc(sl(), sl()));
  sl.registerFactory<IssuesBloc>(() => IssuesBloc(sl(), sl()));
  sl.registerFactory<CommentsBloc>(() => CommentsBloc(sl(), sl()));
  sl.registerFactory<CodeBloc>(() => CodeBloc(sl(), sl()));
}
