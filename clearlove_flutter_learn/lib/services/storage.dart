import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> setString(String key, value) async {
    Future<SharedPreferences> sp = SharedPreferences.getInstance();
    final SharedPreferences _sss = await sp;
    _sss.setString(key, value);
  }

  static Future<String> getString(String key) async {
    Future<SharedPreferences> sp = SharedPreferences.getInstance();
    final SharedPreferences _sss = await sp;
    return _sss.getString(key);
  }

  static Future<void> remove(String key) async {
    Future<SharedPreferences> sp = SharedPreferences.getInstance();
    final SharedPreferences _sss = await sp;
    _sss.remove(key);
  }

  static Future<void> clear() async {
    Future<SharedPreferences> sp = SharedPreferences.getInstance();
    final SharedPreferences _sss = await sp;
    _sss.clear();
  }
}
