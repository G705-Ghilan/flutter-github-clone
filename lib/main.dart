import 'package:flutter/material.dart';
import 'package:github_clone/dependencies_injection.dart';
import 'package:github_clone/src/src.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();
  runApp(const GithubCloneApp());
}

class GithubCloneApp extends StatelessWidget {
  const GithubCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return SystemArea(
          systemNavigationBarColor: context.colorScheme.background,
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
