import 'package:tubtrunk/Models/timerRecord.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatisticController {
  int _failedFocusTimes;
  int _succeedFocusTimes;
  int _totalFocusTimes;
  List<TimerRecord> _timerRecords;

  StatisticController() {
    _failedFocusTimes = 0;
    _succeedFocusTimes = 0;
    _totalFocusTimes = 0;
  }

  Future<int> fetchTimerRecord() async {
    var map = new Map<String, String>();
    map["UserID"] = "1";

    var response = await http.post(
        GlobalSettings.ServerAddress + "getTimerRecordsForUser.php",
        body: map
    );

    if (response.statusCode == 200) {
      _timerRecords = List<TimerRecord>.from(json.decode(response.body).map((tr) => TimerRecord.fromJson(tr)));
      _totalFocusTimes = _timerRecords != null ? _timerRecords.length : 0;

      _succeedFocusTimes = _failedFocusTimes = 0;
      for (int i = 0; i < _timerRecords.length; i++) {
        if (_timerRecords[i].completed == 1)
          ++_succeedFocusTimes;
        else
          ++_failedFocusTimes;
      }
      return _totalFocusTimes;
    }

    return 0;
  }

  int getTotalFocusTimes() {
    return _totalFocusTimes;
  }

  int getSucceedFocusTimes() {
    return _succeedFocusTimes;
  }

  int getSucceedPercentage() {
    if (_totalFocusTimes == 0)
      return 0;

    return _succeedFocusTimes * 100 ~/ _totalFocusTimes;
  }

  int getFailedFocusTimes() {
    return _failedFocusTimes;
  }

  int getFailedPercentage() {
    if (_totalFocusTimes == 0)
      return 0;

    return _failedFocusTimes * 100 ~/ _totalFocusTimes;
  }
}