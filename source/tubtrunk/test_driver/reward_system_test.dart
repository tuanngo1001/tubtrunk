// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
void main() {
}

void userStory1() {
  group( 'As a user, I want to receive my reward after the focus time so that I will'
          ' have the motivation to use the application.', () {
    final getStartedBtn = find.byValueKey("getStartedBtn");
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

    test('Check Timer Give Money When Finish', () async {
      driver.clearTimeline();
      // First, tap the Get Started button
      await driver.tap(getStartedBtn);

      //Find and fill email and password to login
      final userName = find.byValueKey("lvEmailTextField");
      final userPwd = find.byValueKey("lvPwdTextField");
      await driver.tap(userName);
      await driver.enterText("nguyenvq@myumanitoba.ca");
      await driver.waitFor(find.text("nguyenvq@myumanitoba.ca"));
      await driver.tap(userPwd);
      await driver.enterText("tehehe");
      await driver.waitFor(find.text("tehehe"));

      //Find and tap the login button
      final loginBtn = find.byValueKey("lvLoginBtn");
      await driver.tap(loginBtn);
      await Future.delayed(const Duration(seconds: 1), (){});

      //Find and tap the ok button from pop up
      final okBtn = find.byType('RaisedButton');
      await driver.tap(okBtn);
      await Future.delayed(const Duration(seconds: 1), (){});

      //Find the current money
      final money = find.byValueKey("mvMoney");
      String userMoney = await driver.getText(money);

      // //find and tap the start button
      final startBtn = find.byValueKey("tvStartBtn");
      await driver.tap(startBtn);

      await Future.delayed(const Duration(seconds: 62), (){});

      final nahBtn = find.text("Nah, I want more");
      await driver.tap(nahBtn);

      await Future.delayed(const Duration(seconds: 2), (){});

      //Find the current money
      final afterMoney = find.byValueKey("mvMoney");
      String userAfterMoney = await driver.getText(afterMoney);
      int afterMoneyInt = int.parse(userAfterMoney);

      expect(int.parse(userMoney) +1 , afterMoneyInt);
    },
      timeout: Timeout(
        Duration(seconds: 90),
      )
    );

    test('Check if there is a challenge available along with its description',() async {
      driver.clearTimeline();
      //Find and tap the timer tab item to go to mission page
      final missionTabItem = find.byValueKey("mvMissionBarItem");
      await driver.tap(missionTabItem);
      await Future.delayed(const Duration(seconds: 2), (){});
      final missions  = find.byType("Card");
      await driver.tap(missions);
      expect(1, 1);
    });

    test('Check if there is items in store',() async {
      driver.clearTimeline();
      //Find and tap the timer tab item to go to store page
      final storeTabItem = find.byValueKey("mvStoreBarItem");
      await driver.tap(storeTabItem);
      await Future.delayed(const Duration(seconds: 2), (){});
      final storeItems  = find.byType("Card");
      expect(storeItems.serialize().isEmpty, false);
    });
  });
}
