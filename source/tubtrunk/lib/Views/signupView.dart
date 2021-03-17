import 'package:flutter/material.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'mainView.dart';
import 'loginView.dart';
import 'package:http/http.dart' as http;

import 'notificationView.dart';


class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  String uEmail = "";
  String uPassword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
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
          )),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (text){
                      uEmail = text;
                    },
                    decoration: InputDecoration(
                        labelText: "EMAIL",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xfff97c7c)))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    onChanged: (text){
                      uPassword = text;
                    },
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
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "CONFIRM PASSWORD",
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
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          splashColor: Color(0xffee6969),
                          color: Color(0xfff97c7c),
                          elevation: 7.0,
                          onPressed: () {
                            signUpNewUSer(uEmail, uPassword);
                            //print(uEmail);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MainView()),
                            // );
                          },
                          child: Center(
                            child: Text('SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ))),
                ],
              )),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Already have an account?',
                  style:
                      TextStyle(color: Colors.grey, fontFamily: 'Montserrat')),
              SizedBox(width: 5.0),
              InkWell(
                  onTap: () {
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
          )
        ]));
  }


  void signUpNewUSer(String uEmail, String uPassword) async{
    var map = new Map<String,String>();
    map["UserEmail"] = uEmail;
    map["UserPassword"] = uPassword;
    map["UserName"] = "User"; //Default name, they can change it later.

    var response = await http.post(GlobalSettings.serverAddress+"addNewUser.php", body:map);
    print(response.body);
    if(response.body =="Already Exist"){
      showDialog(
          context: context,
          builder: (_) => new NotificationView().userAlreadyExistWarning(context));
    }else if(response.body == "Success"){
      showDialog(
          context: context,
          builder: (_) => new NotificationView().SuccessSignUpPopUp(context));
      await Future.delayed(const Duration(seconds: 3), (){
        Navigator.popUntil(context, (route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainView()),
        );
      });

    }
  }
}
