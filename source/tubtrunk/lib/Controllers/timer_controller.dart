import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:tubtrunk/Controllers/main_controller.dart';
import 'package:tubtrunk/Controllers/notifications_controller.dart';
import 'package:tubtrunk/Utils/global_settings.dart';
import 'package:http/http.dart' as http;

class TimerController {
  CountDownController _countDownController;
  CountDownController get countDownController => _countDownController;

  int _duration;
  int get duration => _duration;

  bool _stopped;
  bool get stopped => _stopped;

  bool _resumable;
  bool get resumable => _resumable;

  bool _finished;
  bool get finished => _finished;

  String _stopStartButtonText;
  String get stopStartButtonText => _stopStartButtonText;

  DateTime _startDateTime;
  Timer _lockScreenTimer;

  // Private constructor
  TimerController._internal() {
    _countDownController = CountDownController();
    _duration = 60;
    _stopped = true;
    _resumable = false;
    _finished = false;
    _stopStartButtonText = "Start";
  }

  //Singleton
  static TimerController _instance;
  factory TimerController() {
    if (_instance == null) {
      _instance = TimerController._internal();
    }
    return _instance;
  }

  void updateStartDateTime() {
    _startDateTime = DateTime.now();
  }

  Future<void> saveTimerRecord(
      {int duration: 0,
      bool completed: false,
      http.Client clientParameter}) async {
    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();
    map["Date"] = GlobalSettings.dateFormatted.format(_startDateTime);
    map["Time"] = GlobalSettings.timeFormatted.format(_startDateTime);
    map["Duration"] = duration.toString();
    map["Completed"] = completed ? "1" : "0";

    http.Client client;
    if (clientParameter == null) {
      client = http.Client();
    } else {
      client = clientParameter;
    }

    var response = await client
        .post(GlobalSettings.serverAddress + "addTimerRecord.php", body: map);

    if (response.statusCode == 200) {
      print("Successfully saved new timer record");
    } else {
      throw Exception("Failed to save new timer record");
    }
  }

  void chooseDuration(Duration resultingDuration) {
    if (resultingDuration == null || resultingDuration.inSeconds == 0) {
      // if cancelled or 0 minutes selected, use previously selected duration
      _duration = _duration;
    } else {
      _duration = resultingDuration.inSeconds;
      reset();
    }
  }

  void onStart() {
    print('Countdown Started');
    _resumable = true;
    _finished = false;
    updateStartDateTime();
  }

  void onComplete(Function(int) updateProgressCallback) {
    print('Countdown Completed');
    int minutes = _duration ~/ 60;
    updateProgressCallback(minutes);
    MainController().addMoney(minutes);

    countDownController.restart(duration: _duration);
    countDownController.pause();
    _stopped = true;
    _resumable = false;
    _finished = true;
    _stopStartButtonText = "Start";

    saveTimerRecord(duration: minutes, completed: finished);
  }

  void stopStart() {
    if (_stopped) {
      _stopStartButtonText = "Stop";
      _resumable == true
          ? countDownController.resume()
          : countDownController.start();
    } else {
      _stopStartButtonText = "Start";
      countDownController.pause();
    }
    _stopped = !_stopped;
  }

  void reset() {
    if (_resumable) {
      // Reset is pressed when timer is still resumable. This should count as a fail and save to db as such
      saveTimerRecord();
    }
    countDownController.restart(duration: _duration);
    countDownController.pause();
    _stopped = true;
    _resumable = false;
    _finished = false;
    _stopStartButtonText = "Start";
  }

  void startLockscreenTimer() {
    Duration remainingDuration = _parseDuration(_countDownController.getTime());
    _lockScreenTimer = Timer(remainingDuration, () {
      notificationsController.setNotification("Time's Up!!!",
          "Your focus time period is over, click to receive your rewards!");
      notificationsController.showNotification();
    });
  }

  Duration _parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int seconds;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    seconds = int.parse(parts[parts.length - 1]);
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  void stopLockscreenTimer() {
    _lockScreenTimer?.cancel();
    _lockScreenTimer = null;
  }
}
