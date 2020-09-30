import 'package:shared_preferences/shared_preferences.dart';

class SharedUtils {
  /// 添加/获取本地缓存
  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<bool> setDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0;
  }

  static Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }


  /// 清除本地缓存
  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}