import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/memory_controller.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  group("MemoryController Tests: ", () {
    test("Saving Test", () async {
      String testKey = "test";
      String testValue = "value";
      await MemoryController.save(testKey, testValue);
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(testKey);
      expect(value, testValue);
    });
    test("Reading Test", () async {
      String testKey = "test";
      String testValue = "value";
      await SharedPreferences.getInstance().then((prefs) {
        prefs.setString(testKey, testValue);
      });
      String value = await MemoryController.read(testKey);
      expect(value, testValue);
    });
    test("Removing a key-value Test", () async {
      String testKey = "test";
      String testValue = "value";
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(testKey, testValue);

      await MemoryController.removeKey(testKey);
      final value = prefs.getString(testKey);
      expect(value, isNull);
    });
    test("Clear memory Test", () async {
      String testKey = "test";
      String testValue = "value";
      String testKey2 = "test2";
      String testValue2 = "value2";
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(testKey, testValue);
      prefs.setString(testKey2, testValue2);

      await MemoryController.remove();
      final value = prefs.getString(testKey);
      final value2 = prefs.getString(testKey2);
      expect(value, isNull);
      expect(value2, isNull);
    });
  });
}
