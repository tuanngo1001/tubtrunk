import 'package:flutter/material.dart';
import 'loginView.dart';

class LandingView extends StatefulWidget {
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  String text = "";

  void changeText(String text) {
    setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topLeft, end: Alignment.bottomRight,
            //         colors: [Color(0xffFC575E), Color(0xff90D5EC)])),
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
    // return RaisedButton(
    //     color: Color(0xfffc575e),
    //     splashColor: Color(0xff90D5EC),
    //     child: Padding(
    //         padding: EdgeInsets.all(20.0),
    //         child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: <Widget>[
    //               Text('Get Started',
    //                   style: TextStyle(
    //                     // fontFamily: ,
    //                     fontSize: 25,
    //                     fontWeight: FontWeight.w700,
    //                     color: Colors.white,
    //                   )),
    //               Icon(
    //                 Icons.arrow_forward,
    //                 color: Colors.white,
    //               )
    //             ])),
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => LoginView()),
    //       );
    //     })

    return Container(
        height: 60.0,
        width: 270.0,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            splashColor: Color(0xffee6969),
            color: Color(0xfff97c7c),
            elevation: 7.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
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
