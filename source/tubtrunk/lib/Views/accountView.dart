import 'package:flutter/material.dart';
import 'leaderboardView.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}
class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Account'),
      // ),
      body: SafeArea(
          child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LeaderboardView()));
              },
              child: Text("Leaderboard")
          )
      ),
    );
  }
}
