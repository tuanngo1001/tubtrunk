import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
// import 'package:tubtrunk/Controllers/audioController.dart';
import 'package:tubtrunk/Controllers/mainController.dart';
import 'package:tubtrunk/Views/mainView.dart';
import './displayNameView.dart';
import './loginView.dart';
import './signUpView.dart';

class NotificationView extends StatefulWidget {
  final Function rewardStoreViewSetState;
  final MainController _mainController = MainController();

  NotificationView([this.rewardStoreViewSetState]);


  NetworkGiffyDialog giftRecievePopUp(context) {
    return NetworkGiffyDialog(
      image: Image.asset('assets/gifs/giftrecieve.gif'),
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
    return NetworkGiffyDialog(
      image: Image.asset('assets/gifs/purchaseprompt.gif'),
      title: Text('',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        '',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onOkButtonPressed: () async {
        // auController.playByName('success-sfx.mp3');
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
    return NetworkGiffyDialog(
      image: Image.asset('assets/gifs/money.gif'),
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
    return NetworkGiffyDialog(
      image: Image.asset('assets/gifs/alreadyexist.gif'),
      title: Text('Hmm....',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'Your account already exist!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyCancelButton: true,
      onCancelButtonPressed: () {
        Navigator.pop(context);
        SignUpView().clearTextInput();
      },
    );
  }

  Widget errorWarning(context){
    return NetworkGiffyDialog(
      image: Image.asset('assets/gifs/errorwarning.gif'),
      title: Text('Sorry...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'Connecting to server failled...\nPlease try again later!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyCancelButton: true,
      onCancelButtonPressed: () {
        Navigator.pop(context);
        LoginView().clearTextInput();
      },
    );
  }

  Widget autoLoginFail(context){
    String gifURL = "https://media.giphy.com/media/3ohhwiWa2C60XsJCa4/source.mp4";

    return NetworkGiffyDialog(
      image: Image.network(gifURL),
      title: Text('Oops...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'Please Log In Again!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyCancelButton: true,
      onCancelButtonPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
      },
    );
  }

  Widget emailPasswordWarning(context){
    return NetworkGiffyDialog(
      image: Image.asset('assets/gifs/passwordwarning.gif'),
      title: Text('Oops...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'Invalid Email or Password. Try Again!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyCancelButton: true,
      onCancelButtonPressed: () {
        Navigator.pop(context);
        LoginView().clearTextInput();
      },
    );
  }

  Widget successLoginPopUp(context){
    return (
      NetworkGiffyDialog(
      image: Image.asset('assets/gifs/welcome.gif'),
      title: Text('Welcome back!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'You have successfully logged in!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyOkButton: true,
      onOkButtonPressed: () {
        Navigator.popUntil(context, (route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainView()),
        );
        LoginView().clearTextInput();
      },
    )
    );
  }

  Widget successSignUpPopUp(context){
    return (
      NetworkGiffyDialog(
      image: Image.asset('assets/gifs/welcome.gif'),
      title: Text('CONGRATULATION!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'You have successfully signed up!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyOkButton: true,
      onOkButtonPressed: () {
        Navigator.popUntil(context, (route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisplayNameView()),
        );
        SignUpView().clearTextInput();
      },
    )
    );
  }

  Widget missingName(context){
    return NetworkGiffyDialog(
      image: Image.asset('assets/gifs/yournameis.gif'),
      title: Text('What\'s your name?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'Looks like there is some mistake.\nTry Again!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyCancelButton: true,
      onCancelButtonPressed: () {
        Navigator.pop(context);
        DisplayNameView().clearTextInput();
      },
    );
  }

  void changeNameSuccess(context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainView()),
    );
    DisplayNameView().clearTextInput();
  }

  void logoutSuccess(context) {
    Navigator.popUntil(context, (route) => false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  Widget logoutFail(context){
    return NetworkGiffyDialog(
      image: Image.asset('assets/gifs/logoutfail.gif'),
      title: Text('Oops...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
      description: Text(
        'There\'s something wrong.\nTry Again!',
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.TOP,
      onlyCancelButton: true,
      onCancelButtonPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
