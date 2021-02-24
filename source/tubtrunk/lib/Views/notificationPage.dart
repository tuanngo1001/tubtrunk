import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class NotificationPage extends StatefulWidget {
  NetworkGiffyDialog Reward_Popup() {
    String gifURL = "https://media.giphy.com/media/5Y2bU7FqLOuzK/giphy.gif";

    return NetworkGiffyDialog(
      image: Image.network(gifURL),
      title: Text('CONGRATULATION!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'You have received a surprise reward for being focus. Enjoy!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onOkButtonPressed: () {},
      buttonOkText: Text("Check it"),
      buttonOkColor: Colors.lightGreen,
      buttonCancelText: Text("Later"),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
