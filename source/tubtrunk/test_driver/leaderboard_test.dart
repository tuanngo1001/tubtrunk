import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('Leaderboard acceptance tests', () {
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

    test('Check if there is a  users list after clicking leaderboard button', () async {
      await driver.clearTimeline();

      final accountTabItem = find.byValueKey("accvAccountBarItem");
      await driver.tap(accountTabItem);
      sleep(Duration(seconds: 2));

      final leaderboardButton = find.byValueKey("leaderboardButton");
      await driver.tap(leaderboardButton);
      sleep(Duration(seconds: 2));

      final userList = find.byValueKey('userList');
      final firstUserName = find.byValueKey('1th username');
      final secondUserName = find.byValueKey('2th username');
      final thirdUserName = find.byValueKey('3th username');

      await driver.scrollIntoView(userList);

      expect(await driver.getText(firstUserName), "Anh Trung");
      expect(await driver.getText(secondUserName), "Anh Thai");
      expect(await driver.getText(thirdUserName), "Anh Nguyen");
    }, timeout: Timeout.none);

    test('Check if user achievement showing up when onclick', () async {
      await driver.clearTimeline();
      final cardButton = find.byValueKey("1st cardButton");
      final userAchievementDialog = find.byValueKey("1st userAchievement");
      final averageFocusTime = find.byValueKey("1st lbvAvgTime");
      final totalTime = find.byValueKey("1st lbvTotalTime");
      final successSessions = find.byValueKey("1st lbvSuccessSessions");
      final missionsPrize = find.byValueKey("1st lbvPrize");
      final moneyAmount = find.byValueKey("1st lbvMoneyAmount");

      await driver.tap(cardButton);
      sleep(Duration(seconds: 2));

      expect(await driver.getText(userAchievementDialog), "Anh Trung's Achievement");
      expect(await driver.getText(averageFocusTime), isNotEmpty);
      expect(await driver.getText(totalTime), isNotEmpty);
      expect(await driver.getText(successSessions), isNotEmpty);
      expect(await driver.getText(missionsPrize), isNotEmpty);
      expect(await driver.getText(moneyAmount), isNotEmpty);
    }, timeout: Timeout.none);
  });
}
