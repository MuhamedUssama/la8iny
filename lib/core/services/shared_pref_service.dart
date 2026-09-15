import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void>? setString(String key, String value) {
    return _prefs?.setString(key, value);
  }

  static Future<void>? setInt(String key, int value) {
    return _prefs?.setInt(key, value);
  }

  static Future<void>? setBool(String key, bool value) {
    return _prefs?.setBool(key, value);
  }

  static String? getString(String key) => _prefs?.getString(key);

  static int? getInt(String key) => _prefs?.getInt(key);

  static bool? getBool(String key) => _prefs?.getBool(key);

  static Future<void>? remove(String key) {
    if (kDebugMode) {
      print("remove$key");
    }
    return _prefs?.remove(key);
  }

  static Future<void>? clear() {
    if (kDebugMode) {
      print("Clear ALl");
    }
    return _prefs?.clear();
  }
}
