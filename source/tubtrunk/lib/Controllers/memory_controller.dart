import 'package:shared_preferences/shared_preferences.dart';

class MemoryController {
  static Future save(String inputKey, String inputValue) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString(inputKey, inputValue);
      print('saved $inputKey: $inputValue.');
    });
  }

  static Future<String> read(String inputKey) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(inputKey) ?? "";
    print('read $inputKey: $value.');
    return value;
  }

  static Future remove() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
      print('cleared local memory.');
    });
  }

  static Future removeKey(String key) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.remove(key);
      print('removed $key.');
    });
  }
}
