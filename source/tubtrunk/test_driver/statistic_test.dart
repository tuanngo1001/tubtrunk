import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('Statistic acceptance tests.', () {
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

    test('Check if all the summary shows up', () async {
      await driver.clearTimeline();
      final statTabItem = find.byValueKey("stvStatBarItem");
      await driver.tap(statTabItem);
      sleep(Duration(seconds: 3));
      final statSummary = find.byValueKey("stvSummary");
      final succeedIndicator = find.text("Succeed");
      final failedIndicator = find.text("Failed");
      final succeedProportion = find.byValueKey("stvSucceedProportion");
      final failedProportion = find.byValueKey("stvFailedProportion");

      assert(await driver.getText(statSummary) != null);
      assert(await driver.getText(succeedProportion) != null);
      assert(await driver.getText(failedProportion) != null);
      expect(await driver.getText(succeedIndicator), "Succeed");
      expect(await driver.getText(failedIndicator), "Failed");
    }, timeout: Timeout.none);

    test('Check if there is a records list when navigating to history tab', () async {
      await driver.clearTimeline();
      final historyTab = find.byValueKey("stvHistoryTab");
      await driver.tap(historyTab);
      sleep(Duration(seconds: 2));

      final recordsList = find.byValueKey('stvTimeRecordsList');
      final recordTitle = find.byValueKey('1st stvRecordTitle');
      sleep(Duration(seconds: 2));
      assert(recordsList != null);
      assert(await driver.getText(recordTitle) != null);
    }, timeout: Timeout.none);
  });
}
