import 'package:flutter/cupertino.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../Models/timerRecord.dart';
import '../Views/TimerView.dart';
import '../Controllers/RewardMissionController.dart';

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

  void chooseDuration(Duration resultingDuration) {
    if (resultingDuration == null ||
        resultingDuration.inSeconds == 0) {
      // if cancelled or 0 minutes selected, use previously selected duration
      _duration = _duration;
    } else {
      _duration = resultingDuration.inSeconds;
    }
    print(_duration);
  }

  void onStart() {
    print('Countdown Started');
    _resumable = true;
    _finished = false;
  }

  void onComplete() {
    print('Countdown Ended');
    _rewardMissionController.updateRequirementProgress(_duration); // Send the duration to the missionController to calculate the money user receives
    countDownController.restart(duration: _duration);
    countDownController.pause();
    _stopped = true;
    _resumable = false;
    _finished = true;
    _stopStartButtonText = "Start";
  }

  void stopStart() {
    if (stopped) {
      resumable == true ? countDownController.resume() : countDownController.start();
    } else {
      countDownController.pause();
    }
      _stopped
          ? _stopStartButtonText = "Stop"
          : _stopStartButtonText = "Start";
      _stopped = !stopped;
  }

  void reset() {
    countDownController.restart(duration: _duration);
    countDownController.pause();
    _stopped = true;
    _resumable = false;
    _finished = false;
    _stopStartButtonText = "Start";
  }
}