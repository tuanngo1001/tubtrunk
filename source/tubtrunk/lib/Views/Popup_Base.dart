import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class Popup_Base extends StatefulWidget {

  NetworkGiffyDialog GiftRecievePopUp() {
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


  NetworkGiffyDialog PurchasePopUp(context) {
    String gifURL = "https://media.giphy.com/media/d906FK91VCXsbDxBu6/giphy.gif";

    return NetworkGiffyDialog(
      image: Image.network(gifURL),
      title: Text('',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        '',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onOkButtonPressed: () {
        showDialog(
            context: context, builder: (_) => new Popup_Base().GiftRecievePopUp());
        // Perform some action
      },
      buttonOkText: Text("Hell Yeah"),
      buttonOkColor: Colors.lightGreen,
      buttonCancelText: Text("Nope"),
    );
  }

  NetworkGiffyDialog MoneyRecievePopup() {
    String gifURL = "https://media.giphy.com/media/EBSECypExxqvOY6Te1/giphy.gif";

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
      buttonOkText: Text("Shop Now"),
      buttonOkColor: Colors.lightGreen,
      buttonCancelText: Text("Nah, I want more"),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
