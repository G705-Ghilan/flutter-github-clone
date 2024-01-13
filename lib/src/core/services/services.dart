import 'package:get_it/get_it.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:github_clone/src/core/services/features/features.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> servicesInit() async {
  // Shared preferences
  final prefs = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerSingleton<SharedPreferences>(prefs);
  }
  if (prefs.token == null) {
    return;
  }

  // Dio
  final dioClient = DioClient();
  await dioClient.initDioClient(prefs.token!);
  sl.registerSingleton<DioClient>(dioClient);

  // Features
  userProfileFeature();
  usersFeature();
  reposFeature();
  issuesFeature();
  codeFeature();
}
