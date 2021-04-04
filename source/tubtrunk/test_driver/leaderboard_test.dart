import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('Leaderboard Page`s', () {
    FlutterDriver driver;
    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check if there is a  users list', () async {
      await driver.clearTimeline();
      final userList = find.byValueKey('userList');
      final firstUserName = find.byValueKey('1th username');
      final secondUserName = find.byValueKey('2th username');
      final thirdUserName = find.byValueKey('3th username');

      await driver.scrollIntoView(userList);

      expect(await driver.getText(firstUserName), "Anh Trung");
      expect(await driver.getText(secondUserName), "Anh Thai");
      expect(await driver.getText(thirdUserName), "Anh Nguyen");
    }, timeout: Timeout.none);

    test('check if user achievement showing up when onclick', () async {
      await driver.clearTimeline();
      final cardButton = find.byValueKey("1st cardButton");
      final userAchievementDialog = find.byValueKey("1st userAchievement");
      sleep(Duration(seconds: 1));
      await driver.tap(cardButton);
      expect(await driver.getText(userAchievementDialog), "Anh Trung's Achievement");
    }, timeout: Timeout.none);
  });
}
