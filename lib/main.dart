import 'package:flutter/material.dart';
import 'package:github_clone/src/src.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await servicesInit();
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
