import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'package:http/http.dart' as http;

import '../Controllers/rewardMissionController.dart';

class TimerController {
  RewardMissionController _rewardMissionController;

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

  // Private constructor
  TimerController._internal() {
    _rewardMissionController = RewardMissionController();
    _countDownController = CountDownController();
    _duration = 5;
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

  void saveTimerRecord({int duration: 0, bool completed: false}) async {
    var map = new Map<String, String>();
    map["UserID"] = "1";
    map["Date"] = GlobalSettings.dateFormatted.format(_startDateTime);
    map["Time"] = GlobalSettings.timeFormatted.format(_startDateTime);
    map["Duration"] = duration.toString();
    map["Completed"] = completed ? "1" : "0";

    var response = await http
        .post(GlobalSettings.serverAddress + "addTimerRecord.php", body: map);

    if (response.statusCode == 200) {
      print("Successfully saved new timer record");
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

  void onComplete() {
    print('Countdown Completed');
    // _rewardMissionController.updateRequirementProgress(_duration); // Send the duration to the missionController to calculate the money user receives
    countDownController.restart(duration: _duration);
    countDownController.pause();
    _stopped = true;
    _resumable = false;
    _finished = true;
    _stopStartButtonText = "Start";
    int minutes = _duration ~/ 60;
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
    if (_resumable) { // Reset is pressed when timer is still resumable. This should count as a fail and save to db as such
      saveTimerRecord();
    }
    countDownController.restart(duration: _duration);
    countDownController.pause();
    _stopped = true;
    _resumable = false;
    _finished = false;
    _stopStartButtonText = "Start";
  }
}
