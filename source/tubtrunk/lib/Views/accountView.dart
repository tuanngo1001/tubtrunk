import 'package:flutter/material.dart';
import 'leaderboardView.dart';
import 'package:tubtrunk/Controllers/authenticationController.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
  final authenticationController = AuthenticationController();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LeaderboardView()));
            },
            child: Text("Leaderboard",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ))),
        Center(
            child: Container(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            side: BorderSide(color: Colors.grey)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xfff97c7c);
                        return Colors.transparent;
                      }),
                    ),
                    onPressed: () {
                      widget.authenticationController.logout(context);
                    },
                    child: Text('Log out',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ))))),
      ],
    ));
  }
}
