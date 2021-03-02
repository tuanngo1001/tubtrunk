import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/timerController.dart';
import '../Controllers/NotificationsController.dart';
import './NotificationView.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

class TimerView extends StatefulWidget {
  final mission;

  TimerView({this.mission});

  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> with WidgetsBindingObserver {
  final TimerController _timerController = TimerController();
  int _duration = 5;
  bool stopped = true;
  bool resumable = false;
  bool finished = false;
  String stopStartButtonText = "Start";
  String setButtonText = "Reset";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    notificationsController
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationsController.setOnNotificationClick(onNotificationClick);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    if (isBackground && !_timerController.stopped) {
      notificationsController.setNotification("Warning! You've left Tubtrunk!",
          "Your focus time is reset and the ongoing period will be invalid.");
      setState(() {
        _timerController.reset();
      });
    }
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    if (_timerController.finished)
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NotificationView().moneyRecievePopup(context)),
      );
  }

  _button({String title, VoidCallback onPressed}) {
    return Expanded(
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Color(0xfffc575e),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            Duration resultingDuration = await showDurationPicker(
              context: context,
              initialTime: new Duration(seconds: _timerController.duration),
            );
            setState(() {
              _timerController.chooseDuration(resultingDuration);
            });
          },
          child: CircularCountDownTimer(
            duration: _timerController.duration,
            initialDuration: 0,
            controller: _timerController.countDownController,
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 1.5,
            ringColor: Colors.grey[300],
            ringGradient: null,
            fillColor: Colors.orange,
            fillGradient: null,
            backgroundColor: Color(0xfffc575e),
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: TextStyle(
              fontSize: 33.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textFormat: CountdownTextFormat.HH_MM_SS,
            isReverse: true,
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () {
              setState(() {
                _timerController.onStart();
              });
            },
            onComplete: () {
              setState(() {
                _timerController.onComplete();
              });
              _timerController.saveTimerRecord(
                  duration: _duration, completed: finished);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotificationView().moneyRecievePopup(context)),
              );
              notificationsController.setNotification("Time's Up!!!",
                  "Your focus time period is over, click to receive your rewards!");
              notificationsController.showNotification();
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
          ),
          _button(
            title: _timerController.stopStartButtonText,
            onPressed: () {
              setState(() {
                _timerController.stopStart();
              });
            },
          ),
          SizedBox(
            width: 10,
          ),
          _button(
            title: "Reset",
            onPressed: () {
              setState(() {
                _timerController.reset();
              });
            },
          ),
        ],
      ),
    );
  }
}
