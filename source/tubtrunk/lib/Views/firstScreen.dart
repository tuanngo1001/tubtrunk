import 'package:flutter/material.dart';
import 'mainPage.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xffFC575E), Color(0xff90D5EC)])),
            child: Stack(children: <Widget>[
              Center(
                  child: Text('tubtrunk',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Stalinist One',
                          fontSize: 40))),
              Align(
                  alignment: Alignment(0.00, 0.75),
                  child: NavigateButtonWidget())
            ])));
  }
}

class NavigateButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Color(0xfffc575e),
        splashColor: Color(0xff90D5EC),
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Get Started',
                      style: TextStyle(
                        // fontFamily: ,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ])),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        });
  }
}
