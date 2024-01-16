import 'package:flutter/material.dart';
import 'package:github_clone/dependencies_injection.dart';
import 'package:github_clone/github_clone_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();
  runApp(const GithubCloneApp());
}
