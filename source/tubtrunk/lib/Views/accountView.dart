import 'package:flutter/material.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'displayNameView.dart';
import 'leaderboardView.dart';
import 'notificationView.dart';
import 'package:tubtrunk/Controllers/authentication_controller.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
  final authenticationController = AuthenticationController();
  AccountView(this.resetTabItem);
  final void Function(int) resetTabItem;

}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xfff97c7c), Colors.pinkAccent])),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage('assets/user_icon.png'),
                          height: 80,
                          width: 80),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        GlobalSettings.user.username,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 22.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    color: Color(0xfff97c7c),
                                    fontFamily: 'Montserrat',
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  GlobalSettings.user.email,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20.0,
                                      color: Colors.pinkAccent),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14.0)),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Colors.indigo.shade100;
                                    return Colors.white;
                                  }),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DisplayNameView()),
                                  );
                                },
                                child: Text('Change your name',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.redAccent,
                                    ))),
                          ),
                          // SizedBox(width: 10.0),
                          Container(
                            child: ElevatedButton(
                                key: Key("accvLogoutBtn"),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14.0)),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Colors.indigo.shade100;
                                    return Colors.white;
                                  }),
                                ),
                                onPressed: () async {
                                  String returnMessage = await widget
                                      .authenticationController
                                      .logout(context);
                                  if (returnMessage == "Error") {
                                    showDialog(
                                        context: context,
                                        builder: (_) => new NotificationView()
                                            .logoutFail(context));
                                  } else if (returnMessage == "Success") {
                                    widget.resetTabItem(0);
                                    NotificationView().logoutSuccess(context);
                                  }
                                },
                                child: Text('Log out',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.redAccent,
                                    ))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderboardView()));
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Leaderboard",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 26.0,
                        fontWeight: FontWeight.w300),
                    key: Key("leaderboardButton"),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
        ],
      ),
    );
  }
}
