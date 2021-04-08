import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/authentication_controller.dart';
import 'package:tubtrunk/Views/main_view.dart';
import 'package:tubtrunk/Views/popup_view.dart';

class DisplayNameView extends StatefulWidget {
  @override
  _DisplayNameViewState createState() => _DisplayNameViewState();
  final authenticationController = new AuthenticationController();
  final username = new TextEditingController();

  clearTextInput() {
    username.clear();
  }
}

class _DisplayNameViewState extends State<DisplayNameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[buildTitle(), buildBody(context)])));
  }

  Widget buildTitle() {
    return Container(
        child: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.fromLTRB(15.0, 140.0, 0.0, 0.0),
          child: Text('What would you like us',
              style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey))),
      Container(
          padding: EdgeInsets.fromLTRB(15.0, 180.0, 0.0, 0.0),
          child: Row(
            children: <Widget>[
              Text('to call ',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text('YOU',
                  style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff97c7c))),
              Text(' ?',
                  style: TextStyle(
                      fontSize: 44.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))
            ],
          )),
    ]));
  }

  Widget buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
        child: Column(children: <Widget>[
          TextField(
            controller: widget.username,
            decoration: InputDecoration(
                hintText: "Ex: John Doe",
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfff97c7c)))),
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
                    String returnMessage = await widget.authenticationController
                        .changeName(context, widget.username.text.trim());
                    if (returnMessage == "Invalid input") {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              new PopupView().missingName(context));
                    } else if (returnMessage == "Username existed") {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              new PopupView().missingName(context));
                    } else if (returnMessage == "Error") {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              new PopupView().errorWarning(context));
                    } else if (returnMessage == "Success") {
                      PopupView().changeNameSuccess(context);
                    }
                    widget.clearTextInput();
                  },
                  child: Center(
                    child: Text('LET\'S GO!',
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
                  onPressed: () {
                    Navigator.popUntil(context, (route) => false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainView()),
                    );
                  },
                  child: Center(
                    child: Text('Skip for now!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: Colors.black)),
                  ))),
        ]));
  }
}
