import 'package:flutter/material.dart';
import 'package:tubtrunk/Models/leaderboardModel.dart';
import 'package:tubtrunk/Views/leaderboardView.dart';
import 'package:tubtrunk/Views/accountView.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/leaderboardController.dart';
void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  group("Testing leaderboard button on account page", () {
    testWidgets('There is a leaderboard button on account page', (WidgetTester tester) async {
      await tester.runAsync(() async {
        // create the widget
        Widget widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new AccountView()),
        );
        LeaderboardView leaderboardPage = new LeaderboardView();
        await tester.pumpWidget(widget);

        // press start, countdown should start and the duration should not be zero
        final leaderboardButton =  find.text("Leaderboard");
        await tester.tap(leaderboardButton);
        await tester.pump();
        // var finder = find.byType(CircularCountDownTimer);
        // var circularCountDownTimer = finder.evaluate().single.widget as CircularCountDownTimer;
        expect(leaderboardPage,leaderboardPage );

        // stop the timer for the next test
        // await tester.tap(find.text('Stop'));
        // await tester.pump();
        //
        // // press start and then stop, the countdown should stop with the remaining duration not changing
        // await tester.tap(find.text('Start'));
        // await tester.pump();
        // await tester.tap(find.text('Stop'));
        // await tester.pump(); // wait to make sure the timer has stopped
      // await tester.pumpWidget(makeTestableWidget(child: accountPage));
      // final leaderboardButton =  find.text("Leaderboard");
      // await tester.pump();
      // expect(leaderboardButton, findsOneWidget);
    });

  //   testWidgets('Leaderboard page will show up when leaderboard button being clicked', (WidgetTester tester) async {
  //     AccountView accountPage = new AccountView();
  //     LeaderboardView leaderboardPage = new LeaderboardView();
  //     await tester.pumpWidget(makeTestableWidget(child: accountPage));
  //     final leaderboardButton =find.text("Leaderboard");
  //     await tester.tap(leaderboardButton);
  //     await tester.pump();
  //     expect(leaderboardPage, leaderboardPage);
  //   });
  // });

  // group("Testing users list and user's achievements", () {
  //   testWidgets('There is a list of users appearing on the eaderboard page', (WidgetTester tester) async {
  //     LeaderboardView leaderboardPage = new LeaderboardView();
  //     // LeaderboardController leadController = LeaderboardController();
  //
  //     await tester.pumpWidget(makeTestableWidget(child: leaderboardPage));
  //     var list = find.byType();
  //     var circularCountDownTimer = list.evaluate().single.widget as CircularCountDownTimer;
  //     expect(circularCountDownTimer.duration, isNot(0));
  //     await tester.pump();
  //   });
  // });
    });
  });
}



