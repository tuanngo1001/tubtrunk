import 'package:flutter/material.dart';
import 'signUpView.dart';
import '../Controllers/authenticationController.dart';
import 'NotificationView.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
  final authenticationController = new AuthenticationController();
  final email = TextEditingController();
  final password = TextEditingController();

  clearTextInput() {
    email.clear();
    password.clear();
  }
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              buildLoginBody(context),
              SizedBox(height: 30.0),
              buildFooter(context)
            ]));
  }

  Widget buildTitle() {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            child: Text('tub',
                style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold))),
        Container(
            padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
            child: Text('trunk',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff97c7c)))),
        Container(
            padding: EdgeInsets.fromLTRB(210.0, 212.0, 0.0, 0.0),
            child: Icon(
              Icons.alarm,
              size: 40.0,
            )),
      ],
    ));
  }

  Widget buildLoginBody(BuildContext context) {
    return Container(
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
              controller: widget.email,
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
              controller: widget.password,
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
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xffee6969);
                        return Color(0xfff97c7c);
                      }),
                    ),
                    onPressed: () async {
                      String returnMessage =
                          await widget.authenticationController.login(
                              context, widget.email.text, widget.password.text);
                      if (returnMessage == "Invalid input") {
                        showDialog(
                            context: context,
                            builder: (_) => new NotificationView()
                                .emailPasswordWarning(context));
                      } else if (returnMessage == "User not found") {
                        showDialog(
                            context: context,
                            builder: (_) => new NotificationView()
                                .emailPasswordWarning(context));
                      } else if (returnMessage == "Error") {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                new NotificationView().errorWarning(context));
                      } else if (returnMessage == "Success") {
                        showDialog(
                            context: context,
                            builder: (_) => new NotificationView()
                                .successLoginPopUp(context));
                      }
                      widget.clearTextInput();
                    },
                    child: Center(
                      child: Text('LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ))),
            SizedBox(height: 20.0),
            Container(
                height: 40.0,
                child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Colors.transparent;
                      }),
                    ),
                    onPressed: () {},
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: ImageIcon(
                            AssetImage('assets/google_logo.png'),
                            color: Colors.black,
                          )),
                          SizedBox(width: 5.0),
                          Center(
                            child: Text('Log in with Google',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black)),
                          )
                        ]))),
          ],
        ));
  }

  Widget buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('New to Tubtrunk?',
            style: TextStyle(color: Colors.grey, fontFamily: 'Montserrat')),
        SizedBox(width: 5.0),
        InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpView()),
              );
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff97c7c),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ))
      ],
    );
  }
}
