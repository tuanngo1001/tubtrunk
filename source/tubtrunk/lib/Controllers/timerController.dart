import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'package:http/http.dart' as http;

import '../Controllers/rewardMissionController.dart';

class TimerController {
  RewardMissionController _rewardMissionController = RewardMissionController();

  CountDownController _countDownController = CountDownController();
  CountDownController get countDownController => _countDownController;

  int _duration = 5;
  int get duration => _duration;

  bool _stopped = true;
  bool get stopped => _stopped;

  bool _resumable = false;
  bool get resumable => _resumable;

  bool _finished = false;
  bool get finished => _finished;

  String _stopStartButtonText = "Start";
  String get stopStartButtonText => _stopStartButtonText;

  DateTime _startDateTime;

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
    _rewardMissionController.updateRequirementProgress(
        _duration); // Send the duration to the missionController to calculate the money user receives
    countDownController.restart(duration: _duration);
    countDownController.pause();
    _stopped = true;
    _resumable = false;
    _finished = true;
    _stopStartButtonText = "Start";
    saveTimerRecord(duration: _duration, completed: finished);
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
