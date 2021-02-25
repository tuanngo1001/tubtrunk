import 'package:flutter/material.dart';
import 'package:tubtrunk/Models/RewardMission.dart';
import 'package:tubtrunk/Views/missionPage.dart';
import '../Controllers/notificationsController.dart';
import './notificationPage.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

class TimerPage extends StatefulWidget {
  final mission;
  TimerPage({this.mission});////////////////////////////

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {

  CountDownController _controller = CountDownController();
  int _duration = 5;
  bool stopped = true;
  bool resumable = false;
  String stopStartButtonText = "Start";

  @override
  void initState() {
    super.initState();
    notificationsController
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationsController.setOnNotificationClick(onNotificationClick);
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NotificationPage().Reward_Popup()),
    );
  }

  _button({String title, VoidCallback onPressed}) {
    return Expanded(
      child: RaisedButton(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
        color: Color(0xfffc575e),
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
              initialTime: new Duration(seconds: _duration),
            );
            setState(() {
              if (resultingDuration == null ||
                  resultingDuration.inSeconds == 0) {
                // if cancelled or 0 minutes selected, use previously selected duration
                _duration = _duration;
              } else {
                _duration = resultingDuration.inSeconds;
              }
            });
          },
          child: CircularCountDownTimer(
            duration: _duration,
            initialDuration: 0,
            controller: _controller,
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
              print('Countdown Started');
              resumable = true;
            },
            onComplete: () {
              print('Countdown Ended');
              widget.mission.missionController.updateRequirementProgress(1);            ////////// Send the duration to the missionController to calculate the money user receives
              _controller.restart(duration: _duration);
              _controller.pause();
              setState(() {
                stopped = true;
                resumable = false;
                stopStartButtonText = "Start";
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationPage().Reward_Popup()),
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
            title: stopStartButtonText,
            onPressed: () {
              if (stopped) {
                resumable == true ? _controller.resume() : _controller.start();
              } else {
                _controller.pause();
              }
              setState(() {
                stopped
                    ? stopStartButtonText = "Stop"
                    : stopStartButtonText = "Start";
                stopped = !stopped;
              });
            },
          ),

          SizedBox(
            width: 10,
          ),
          _button(
            title: "Reset",
            onPressed: () {
              _controller.restart(duration: _duration);
              _controller.pause();
              setState(() {
                stopped = true;
                resumable = false;
                stopStartButtonText = "Start";
              });
            },
          ),
        ],
      ),
    );
  }
}
