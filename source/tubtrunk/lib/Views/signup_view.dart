import 'package:flutter/material.dart';
import 'package:tubtrunk/Views/login_view.dart';
import 'package:tubtrunk/Controllers/authentication_controller.dart';
import 'package:tubtrunk/Views/notification_view.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
  final authenticationController = new AuthenticationController();
  final email = TextEditingController();
  final password = TextEditingController();

  clearTextInput() {
    email.clear();
    password.clear();
  }
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              buildSignUpBody(context),
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
            child: Text('SIGN UP for',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey))),
        Container(
            padding: EdgeInsets.fromLTRB(15.0, 140.0, 0.0, 0.0),
            child: Text('tub',
                style: TextStyle(
                    fontSize: 70.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))),
        Container(
            padding: EdgeInsets.fromLTRB(120.0, 140.0, 0.0, 0.0),
            child: Text('trunk',
                style: TextStyle(
                    fontSize: 70.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff97c7c)))),
        Container(
            padding: EdgeInsets.fromLTRB(290.0, 169.0, 0.0, 0.0),
            child: Icon(
              Icons.alarm,
              size: 40.0,
            )),
      ],
    ));
  }

  Widget buildSignUpBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: widget.email,
              decoration: InputDecoration(
                  labelText: "EMAIL",
                  hintText: "Ex: example@gmail.com",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff97c7c)))),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: widget.password,
              decoration: InputDecoration(
                  labelText: "PASSWORD",
                  hintText: "At least 4 characters",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff97c7c)))),
              obscureText: true,
            ),
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
                          await widget.authenticationController.signup(
                              context, widget.email.text, widget.password.text);
                      if (returnMessage == "Invalid input") {
                        showDialog(
                            context: context,
                            builder: (_) => new NotificationView()
                                .emailPasswordWarning(context));
                      } else if (returnMessage == "Invalid user") {
                        showDialog(
                            context: context,
                            builder: (_) => new NotificationView()
                                .userAlreadyExistWarning(context));
                      } else if (returnMessage == "Error") {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                new NotificationView().errorWarning(context));
                      } else if (returnMessage == "Success") {
                        String returnMessage2 = await widget
                            .authenticationController
                            .loginAfterSignup(context, widget.email.text,
                                widget.password.text);

                        if (returnMessage2 == "User not found") {
                          showDialog(
                              context: context,
                              builder: (_) => new NotificationView()
                                  .emailPasswordWarning(context));
                        } else if (returnMessage2 == "Error") {
                          showDialog(
                              context: context,
                              builder: (_) =>
                                  new NotificationView().errorWarning(context));
                        } else if (returnMessage2 == "Success") {
                          showDialog(
                              context: context,
                              builder: (_) => new NotificationView()
                                  .successSignUpPopUp(context));
                        }
                      }

                      widget.clearTextInput();
                    },
                    child: Center(
                      child: Text('SIGN UP',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ))),
          ],
        ));
  }

  Widget buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Already have an account?',
            style: TextStyle(color: Colors.grey, fontFamily: 'Montserrat')),
        SizedBox(width: 5.0),
        InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
            child: Text(
              'Log in',
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
