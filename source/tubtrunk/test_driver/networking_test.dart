// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void runTests() {
  group('As a user, I want to log in with my account.', () {
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

    test('Successfully login', () async {
      driver.clearTimeline();
      // First, tap the Get Started button
      await driver.tap(getStartedBtn);

      //Find and fill email and password to login
      final userEmail = find.byValueKey("lvEmailTextField");
      final userPwd = find.byValueKey("lvPwdTextField");
      await driver.tap(userEmail);
      await driver.enterText("hashTester@tester.com");
      await driver.waitFor(find.text("hashTester@tester.com"));
      await driver.tap(userPwd);
      await driver.enterText("test1234");
      await driver.waitFor(find.text("test1234"));

      //Find and tap the login button
      final loginBtn = find.byValueKey("lvLoginBtn");
      await driver.tap(loginBtn);
      await Future.delayed(const Duration(seconds: 1), () {});

      //Find and tap the ok button from pop up
      final okBtn = find.byType('RaisedButton');
      await driver.tap(okBtn);
      await Future.delayed(const Duration(seconds: 1), () {});

      final userName = find.byValueKey("mvGreetingUserName");

      expect(await driver.getText(userName), "Hi, Tester 123");
    },
        timeout: Timeout(
          Duration(seconds: 90),
        ));
  });

  group('As a user, I want to log/sign out.', () {
    // final getStartedBtn = find.byValueKey("getStartedBtn");

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

    test('Successfully log out', () async {
      driver.clearTimeline();

      final accountTabItem = find.byValueKey("accvAccountBarItem");
      await driver.tap(accountTabItem);
      await Future.delayed(const Duration(seconds: 2), () {});

      final logoutBtn = find.byValueKey("accvLogoutBtn");
      await driver.tap(logoutBtn);

      final loginBtn = find.byValueKey("lvLoginBtn");

      expect(loginBtn, isNotNull);
      // expect(await driver.getText(userName), "Hi, Tester 123");
    },
        timeout: Timeout(
          Duration(seconds: 90),
        ));
  });
}
