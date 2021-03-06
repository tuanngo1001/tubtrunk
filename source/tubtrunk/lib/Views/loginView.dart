import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
              child: Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text('Tub',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold))),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                  child: Text('Trunk',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff97c7c)))),
            ],
          )),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: "EMAIL",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfff97c7c)))),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfff97c7c)))),
                    obscureText: true,
                  ),
                  SizedBox(height: 5.0),
                  Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Color(0xfff97c7c),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      )),
                  SizedBox(height: 40.0),
                  Container(
                      height: 40.0,
                      child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Color(0xffee6969),
                          color: Color(0xfff97c7c),
                          elevation: 7.0,
                          child: GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Text('LOGIN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              )))),
                  SizedBox(height: 20.0),
                  Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                  child: ImageIcon(
                                      AssetImage('assets/facebook.png'))),
                              SizedBox(width: 5.0),
                              Center(
                                child: Text('Log in with facebook',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              )
                            ]),
                      ))
                ],
              )),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('New to Tubtrunk?',
                  style:
                      TextStyle(color: Colors.grey, fontFamily: 'Montserrat')),
              SizedBox(width: 5.0),
              InkWell(
                  onTap: () {},
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Color(0xfff97c7c),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ))
            ],
          )
        ]));
  }
}
