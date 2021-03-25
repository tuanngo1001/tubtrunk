import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Views/timerView.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

void main() {
    testWidgets('TimerView widget tests', (WidgetTester tester) async {
      await tester.runAsync(() async {
        // create the widget
        Widget widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new TimerView()),
        );
        await tester.pumpWidget(widget);

        // press start, countdown should start and the duration should not be zero
        await tester.tap(find.text('Start'));
        await tester.pump();
        var finder = find.byType(CircularCountDownTimer);
        var circularCountDownTimer = finder.evaluate().single.widget as CircularCountDownTimer;
        expect(circularCountDownTimer.duration, isNot(0));

        // stop the timer for the next test
        await tester.tap(find.text('Stop'));
        await tester.pump();

        // press start and then stop, the countdown should stop with the remaining duration not changing
        await tester.tap(find.text('Start'));
        await tester.pump();
        await tester.tap(find.text('Stop'));
        await tester.pump(); // wait to make sure the timer has stopped
      });
    });
}
