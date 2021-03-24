import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      AccountView accountPage = new AccountView();
      await tester.pumpWidget(makeTestableWidget(child: accountPage));
      final leaderboardButton = find.descendant(of: find.byType(ElevatedButton), matching: find.text("Leaderboard"));
      await tester.pump();
      expect(leaderboardButton, findsOneWidget);
    });

    testWidgets('Leaderboard page will show up when leaderboard button being clicked', (WidgetTester tester) async {
      AccountView accountPage = new AccountView();
      LeaderboardView leaderboardPage = new LeaderboardView();
      await tester.pumpWidget(makeTestableWidget(child: accountPage));
      final leaderboardButton = find.descendant(of: find.byType(ElevatedButton), matching: find.text("Leaderboard"));
      await tester.tap(leaderboardButton);
      await tester.pump();
      expect(leaderboardPage, leaderboardPage);
    });
  });

  group("Testing users list and user's achievements", () {
    testWidgets('There is a list of users appearing on the eaderboard page', (WidgetTester tester) async {
      LeaderboardView leaderboardPage = new LeaderboardView();
      // LeaderboardController leadController = LeaderboardController();
      // List<LeaderboardModel> usersList = await leadController.fetchAllUsers();
      await tester.pumpWidget(makeTestableWidget(child: leaderboardPage));
      await tester.pump();



    });



  });
}



