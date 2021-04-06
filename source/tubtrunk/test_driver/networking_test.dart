// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void runLoginTest() {
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

      final userName = find.byValueKey("greetingUserName");

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

      final logoutBtn = find.byValueKey("lvLogoutBtn");
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

// void runSignupTest() {
//   group('As a user, I want to sign up with new account.', () {
//     final getStartedBtn = find.byValueKey("getStartedBtn");

//     FlutterDriver driver;

//     // Connect to the Flutter driver before running any tests.
//     setUpAll(() async {
//       driver = await FlutterDriver.connect();
//     });

//     // Close the connection to the driver after the tests have completed.
//     tearDownAll(() async {
//       if (driver != null) {
//         driver.close();
//       }
//     });
//     test('Successfully Signup', () async {
//       driver.clearTimeline();
//       // First, tap the Get Started button
//       await driver.tap(getStartedBtn);

//       final gotoSignUp = find.byValueKey("gotoSignUpView");
//       await driver.tap(gotoSignUp);

//       //Find and fill email and password to signup
//       final userEmail = find.byValueKey("lvEmailTextField");
//       final userPwd = find.byValueKey("lvPwdTextField");
//       await driver.tap(userEmail);
//       // String
//       await driver.enterText("hashTesterRandom@tester.com");
//       await driver.waitFor(find.text("hashTester@tester.com"));
//       await driver.tap(userPwd);
//       await driver.enterText("test1234");
//       await driver.waitFor(find.text("test1234"));

//       //Find and tap the signup button
//       final signupBtn = find.byValueKey("lvSignupBtn");
//       await driver.tap(signupBtn);
//       await Future.delayed(const Duration(seconds: 1), () {});

//       //Find and tap the ok button from pop up
//       final okBtn = find.byType('RaisedButton');
//       await driver.tap(okBtn);
//       await Future.delayed(const Duration(seconds: 1), () {});

//       final changeName = find.byValueKey("changeNameTitle");

//       expect(await driver.getText(changeName), "What would you like us");
//     },
//         timeout: Timeout(
//           Duration(seconds: 90),
//         ));
//   });
// }
