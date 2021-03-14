import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tubtrunk/Controllers/audioController.dart';
import 'package:tubtrunk/Controllers/mainController.dart';


class NotificationView extends StatefulWidget {

  AudioController auController = new AudioController();

  Function rewardStoreViewSetState;
  MainController _mainController = MainController();

  NotificationView([this.rewardStoreViewSetState]);


  NetworkGiffyDialog giftRecievePopUp(context) {
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

  NetworkGiffyDialog purchasePopUp(context,void Function(int) removeStoreItem, int index) {
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
      onOkButtonPressed: () async {
        auController.playByName('success-sfx.mp3');
        removeStoreItem(index);
        this.rewardStoreViewSetState(index);
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (_) => new NotificationView(rewardStoreViewSetState).giftRecievePopUp(context));
        // Perform some action
      },
      buttonOkText: Text("Hell Yeah"),
      buttonOkColor: Colors.lightGreen,
      buttonCancelText: Text("Nope"),
    );
  }

  NetworkGiffyDialog moneyReceivePopup(context) {
    String gifURL =
        "https://media.giphy.com/media/EBSECypExxqvOY6Te1/giphy.gif";

    return NetworkGiffyDialog(
      image: Image.network(gifURL),
      title: Text('CONGRATULATIONS!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'You have received a surprise reward for being focused. Enjoy!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onOkButtonPressed: () {
        Navigator.of(context).pop();
        // Switch to store view
        _mainController.changeMainView(2);
      },
      buttonOkText: Text("Shop Now"),
      buttonOkColor: Colors.lightGreen,
      buttonCancelText: Text("Nah, I want more"),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
