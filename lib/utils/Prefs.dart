import 'package:shared_preferences/shared_preferences.dart';


class Prefs {
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setPrefStr(String key, String value) async =>
      await _preferences.setString(key, value);

  static String? getPrefStr(String key) => _preferences.getString(key);

  static Future setPrefIn(String key, int value) async =>
      await _preferences.setInt(key, value);

  static int getPrefIn(String key) => _preferences.getInt(key) ?? 0;

  static Future setPrefBl(String key, bool value) async =>
      await _preferences.setBool(key, value);

  static bool getPrefBl(String key) => _preferences.getBool(key) ?? false;

  static Future deleteByKey(String key) async {
    await _preferences.remove(key);
  }

  static Future deleteAllData() async {
    await _preferences.clear();
  }

/* Prefs.setPrefStr("name", "Sikandar");
  var nm= Prefs.getPrefStr("name");
  print("Name:: $nm");*/

}