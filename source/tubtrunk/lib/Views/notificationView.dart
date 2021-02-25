import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tubtrunk/Views/rewardStoreView.dart';

class NotificationView extends StatefulWidget {
  NetworkGiffyDialog GiftRecievePopUp(context) {
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
      onOkButtonPressed: () {
        Navigator.of(context).pop();
      },
      onlyOkButton: true,
      buttonOkText: Text("OK!"),
      buttonOkColor: Colors.lightGreen,
    );
  }

  NetworkGiffyDialog PurchasePopUp(context) {
    String gifURL =
        "https://media.giphy.com/media/d906FK91VCXsbDxBu6/giphy.gif";

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
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (_) => new NotificationView().GiftRecievePopUp(context));
        // Perform some action
      },
      buttonOkText: Text("Hell Yeah"),
      buttonOkColor: Colors.lightGreen,
      buttonCancelText: Text("Nope"),
    );
  }

  NetworkGiffyDialog MoneyRecievePopup(context) {
    String gifURL =
        "https://media.giphy.com/media/EBSECypExxqvOY6Te1/giphy.gif";

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
      onOkButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RewardStoreView()),
        );
      },
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
