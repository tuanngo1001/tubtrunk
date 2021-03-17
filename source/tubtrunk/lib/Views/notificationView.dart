import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tubtrunk/Controllers/mainController.dart';

class NotificationView extends StatefulWidget {

  MainController _mainController = MainController();

  NetworkGiffyDialog giftReceivePopUp(context) {
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

  NetworkGiffyDialog purchasePopUp(context) {
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
            builder: (_) => new NotificationView().giftReceivePopUp(context));
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

  Widget userAlreadyExistWarning(context){
    String gifURL = "https://media.giphy.com/media/Y08bx6Fea1BafzTlvc/giphy.gif";

    return NetworkGiffyDialog(
      image: Image.network(gifURL),
      title: Text('Hmm....',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'Your account already exist!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyOkButton: true,
      onlyCancelButton: true,
    );
    // return Dialog(
    //     backgroundColor: Colors.transparent,
    //     insetPadding: EdgeInsets.all(10),
    //     child: Stack(
    //       clipBehavior: Clip.none, alignment: Alignment.center,
    //       children: <Widget>[
    //         Container(
    //           width: 210,
    //           height: 210,
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(15),
    //               color: Color(0xfff97c7c),
    //           ),
    //           padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
    //           child: Text("User Already Exist",
    //               style: TextStyle(fontSize: 21),
    //               textAlign: TextAlign.center
    //           ),
    //         ),
    //         Positioned(
    //             bottom: -22,
    //             child: Image.network("https://media.giphy.com/media/Y08bx6Fea1BafzTlvc/giphy.gif", width: 200, height: 200)
    //         )
    //       ],
    //     )
    // );
  }

  Widget PasswordWarning(){
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xfff97c7c),
              ),
              padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
              child: Text("Invalid Password. Please Try Again",
                  style: TextStyle(fontSize: 21),
                  textAlign: TextAlign.center
              ),
            ),
            Positioned(
                bottom: -22,
                child: Image.network("https://media.giphy.com/media/IgLIVXrBcID9cExa6r/giphy.gif", width: 200, height: 200)
            )
          ],
        )
    );
  }

  Widget SuccessSignUpPopUp(context){
    String gifURL = "https://media.giphy.com/media/xUPGGDNsLvqsBOhuU0/giphy.gif";

    return NetworkGiffyDialog(
      image: Image.network(gifURL),
      title: Text('CONGRATULATION!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'You have successfully signed up. Login!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyOkButton: true,
      onlyCancelButton: true,
    );
    // return Dialog(
    //     // backgroundColor: Colors.transparent,
    //     insetPadding: EdgeInsets.all(10),
    //     child: Stack(
    //       clipBehavior: Clip.none, alignment: Alignment.center,
    //       children: <Widget>[
    //         // Container(
    //         //   // width: 210,
    //         //   // height: 210,
    //         //   decoration: BoxDecoration(
    //         //     borderRadius: BorderRadius.circular(15),
    //         //     color: Color(0xfff97c7c),
    //         //   ),
    //         //   padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
    //         //   child: Text("",
    //         //       style: TextStyle(fontSize: 21),
    //         //       textAlign: TextAlign.center
    //         //   ),
    //         // ),
    //         Positioned(
    //             bottom: -22,
    //             child: Image.network("https://media.giphy.com/media/xUPGGDNsLvqsBOhuU0/giphy.gif", width: 200, height: 200)
    //         )
    //       ],
    //     )
    // );
  }


  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
