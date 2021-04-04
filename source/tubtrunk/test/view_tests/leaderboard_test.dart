import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Leaderboard Page', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.



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

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      final userList = find.byValueKey('userList');
      // final userCard = find.byValueKey('userCard');
      // final userRank = find.byValueKey('rank: 4');
      final userName = find.byValueKey('1th username');
      // final userMinutes = find.byValueKey('4th user`s minutes');
      await driver.scrollUntilVisible(
        userList,
        userName,
        dyScroll: -300.0,
      );
      expect(await driver.getText(userName), "Anh Trung");
    });

  });
}