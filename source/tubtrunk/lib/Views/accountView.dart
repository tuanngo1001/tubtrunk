import 'package:flutter/material.dart';
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
          Center(
            child: Container(
            height: 50.0,
            width: 150.0,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                    side: BorderSide(color: Colors.grey)),
                splashColor: Color(0xfff97c7c),
                color: Colors.transparent,
                elevation: 0.0,
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
      )
    );
  }
}
