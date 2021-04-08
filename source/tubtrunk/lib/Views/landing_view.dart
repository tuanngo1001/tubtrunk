import 'package:flutter/material.dart';
import 'package:tubtrunk/Views/login_view.dart';
import 'package:tubtrunk/Controllers/authentication_controller.dart';
import 'package:tubtrunk/Views/main_view.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color(0xfffffff0),
            child: Stack(children: <Widget>[
              Container(
                  child: Stack(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(15.0, 210.0, 0.0, 0.0),
                      child: Text('tub',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold))),
                  Container(
                      padding: EdgeInsets.fromLTRB(135.0, 210.0, 0.0, 0.0),
                      child: Text('trunk',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xfff97c7c)))),
                ],
              )),
              Align(
                  alignment: Alignment(0.00, 0.75),
                  child: NavigateButtonWidget())
            ])));
  }
}

class NavigateButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.0,
        width: 270.0,
        child: ElevatedButton(
            key: Key('getStartedBtn'),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed))
                  return Color(0xffee6969);
                return Color(0xfff97c7c);
              }),
            ),
            onPressed: () async {
              await AuthenticationController.rememberMe(context)
                  .then((returnMessage) {
                print(returnMessage);
                if (returnMessage == "Success") {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainView()),
                  );
                } else {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                }
              });
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Get Started',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ])));
  }
}