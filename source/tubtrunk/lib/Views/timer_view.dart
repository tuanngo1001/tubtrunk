import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/timer_controller.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:tubtrunk/Views/music_library_view.dart';

import 'package:tubtrunk/Controllers/notifications_controller.dart';
import 'package:tubtrunk/Views/popup_view.dart';

class TimerView extends StatefulWidget {
  final Function(int) updateProgressCallback;

  TimerView({Key key, this.updateProgressCallback}) : super(key: key);

  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final TimerController _timerController = TimerController();

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
  bool get wantKeepAlive => true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (_timerController.stopped) return;

    if (state == AppLifecycleState.inactive) {
      if (await isLockScreen()) {
        _timerController.startLockscreenTimer();
      } else {
        notificationsController.setNotification(
            "Warning! You've left Tubtrunk!",
            "You have been assessed a failed session.");
        notificationsController.showNotification();
        setState(() {
          _timerController.reset();
        });
      }
    } else if (state == AppLifecycleState.resumed) {
      _timerController.stopLockscreenTimer();
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
                PopupView().moneyReceivePopup(context)),
      );
  }

  _button({String title, VoidCallback onPressed, String key}) {
    return Expanded(
      key: Key(key),
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Color(0xfff97c7c),
        ),
      ),
    );
  }

  Widget _confirmationDialog({
    Text text,
    VoidCallback cancelOnPressed,
    VoidCallback okOnPressed,
  }) {
    return new AlertDialog(
      title: Text("Confirmation"),
      content: text,
      actions: [
        TextButton(
          onPressed: cancelOnPressed,
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: okOnPressed,
          child: Text("Ok"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Color(0xfff97c7c),
                mini: true,
                child: const Icon(Icons.audiotrack_rounded),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicLibraryView(),
                  ),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                Duration resultingDuration = await showDurationPicker(
                  context: context,
                  initialTime: new Duration(seconds: _timerController.duration),
                );
                if (_timerController.resumable) {
                  print("Asking for confirmation");
                  // Timer running, ask for confirmation to set duration
                  // Confirmation dialog
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _confirmationDialog(
                        text: Text(
                            "Changing the duration now would result in a failure for this session, are you sure?"),
                        cancelOnPressed: () {
                          Navigator.of(context).pop();
                        },
                        okOnPressed: () {
                          Navigator.of(context).pop();
                          _timerController.chooseDuration(resultingDuration);
                        },
                      );
                    },
                  );
                } else {
                  // Timer not started, set duration as per normal
                  setState(() {
                    _timerController.chooseDuration(resultingDuration);
                  });
                }
              },
              child: CircularCountDownTimer(
                duration: _timerController.duration,
                initialDuration: 0,
                controller: _timerController.countDownController,
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 1.5,
                ringColor: Colors.grey[300],
                ringGradient: null,
                fillColor: Colors.yellow.shade200,
                fillGradient: null,
                backgroundColor: Color(0xfff97c7c),
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
                    _timerController.onComplete(widget.updateProgressCallback);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PopupView().moneyReceivePopup(context)),
                  );
                },
                key: Key('tvCircularCountdownTimer'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
          ),
          _button(
            title: _timerController.stopStartButtonText,
            key: "tvStartBtn",
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
            key: "tvResetBtn",
            onPressed: () async {
              if (_timerController.resumable) {
                print("Asking for confirmation");
                // Timer running, ask for confirmation to reset
                // Confirmation dialog
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _confirmationDialog(
                      text: Text(
                          "Resetting now would result in a failure for this session, are you sure?"),
                      cancelOnPressed: () {
                        Navigator.of(context).pop();
                      },
                      okOnPressed: () {
                        Navigator.of(context).pop();
                        _timerController.reset();
                      },
                    );
                  },
                );
              } else {
                // Timer not started, reset timer as usual
                setState(() {
                  _timerController.reset();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
