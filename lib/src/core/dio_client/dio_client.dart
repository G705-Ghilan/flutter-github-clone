import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:github_clone/src/core/core.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  late final Dio dio;
  late final CacheOptions options;

  Future<void> initDioClient(String token) async {
    var cacheDir = await getTemporaryDirectory();

    logInfo("Cache dir: ${cacheDir.path} ...");

    var cacheStore = HiveCacheStore(
      cacheDir.path,
      hiveBoxName: "hive_dio_cache",
    );
    // await cacheStore.clean();
    options = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      maxStale: const Duration(days: 5),
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) {
        return request.uri.toString();
      },
      allowPostMethod: false,
    );

    dio = Dio(
      BaseOptions(
        baseUrl: Api.baseUrl,
        headers: {
          "Accept": "application/vnd.github+json",
          'Authorization': 'Bearer $token',
        },
        validateStatus: (status) => true,
      ),
    );
    dio.interceptors.add(DioCacheInterceptor(options: options));
  }

  // refresh option if online, or cached data if offline
  Future<Options> refreshIfConnectedOption() async {
    final netOptions =
        await InternetAddress.lookup('example.com').then<CacheOptions>(
      (result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return options.copyWith(policy: CachePolicy.refreshForceCache);
        }
        return options;
      },
      onError: (p) => options,
    );
    return netOptions.toOptions();
  }
}
