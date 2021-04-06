import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void runTests() {
  group('Timer tests', () {
    final timerViewButtonFinder = find.byValueKey('mvTimerBarItem');
    final stopStartButtonFinder = find.byValueKey('tvStartBtn');
    final resetButtonFinder = find.byValueKey('tvResetBtn');
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Test start/stop button', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(timerViewButtonFinder);
        await driver.tap(stopStartButtonFinder);
        await Future.delayed(Duration(seconds: 5));
        expect(find.text('Stop'), isNotNull);
        await driver.tap(stopStartButtonFinder);
        expect(find.text('Start'), isNotNull);
      });
    });

    test('Test reset button', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(resetButtonFinder);
        expect(find.text('Ok'), isNotNull);
        await driver.tap(find.text('Ok'));
      });
    });

    test('Test notification on completion of session', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(timerViewButtonFinder);
        await driver.tap(stopStartButtonFinder);
        await Future.delayed(Duration(seconds: 60));
        // find popup notification
        expect(find.byValueKey('nvMoneyReceivePopup'), isNotNull);
        await driver.tap(find.text('Nah, I want more'));
      });
    },
      timeout: Timeout(
        Duration(seconds: 90),
      ));
  });
}