// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
void main() {
  group('Tubtrunk App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
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

    test('Get Started', () async {
      // First, tap the button.
      await driver.tap(getStartedBtn);

      final userName = find.byValueKey("emailTextField");
      final userPwd = find.byValueKey("PwdTextField");

      await driver.tap(userName);
      await driver.enterText("nguyenvq@myumanitoba.ca");
      await driver.waitFor(find.text("nguyenvq@myumanitoba.ca"));

      await driver.tap(userPwd);
      await driver.enterText("tehehe");
      await driver.waitFor(find.text("tehehe"));

      final loginBtn = find.byValueKey("loginBtn");

      await driver.tap(loginBtn);

      // Then, verify the counter text is incremented by 1.
      //expect(await driver.getText(loginBtn), "LOGIN");
    });
  });
}