import 'package:shared_preferences/shared_preferences.dart';

extension SharedPrefrencesExtension on SharedPreferences {
  String? get token => getString("token");
}
