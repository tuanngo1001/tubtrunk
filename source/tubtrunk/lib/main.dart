import 'package:flutter/material.dart';
import 'package:tubtrunk/Views/notificationPage.dart';
import 'package:tubtrunk/Views/Sample_Timer_Page.dart';
import './Views/firstScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tubtrunk App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstScreen(),
    );
  }
}
