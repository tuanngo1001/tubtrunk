import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Views/timerView.dart';

void main() {
    testWidgets('TimerView widget tests', (WidgetTester tester) async {
      // create the widget
      await tester.pumpWidget(new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new TimerView()),
      ));

      await tester.tap(find.text('Start'));
      await tester.pump();
      expect(find.text('Stop'), findsOneWidget);
    });
}
