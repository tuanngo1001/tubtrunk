import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:tubtrunk/Views/leaderboardView.dart' as leaderboardPage;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  Widget widget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: leaderboardPage.LeaderboardView()),
  );
  runApp(widget);
}
