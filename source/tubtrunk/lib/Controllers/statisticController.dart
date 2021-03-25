import 'package:tubtrunk/Models/timerRecordModel.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatisticController {
  int _failedFocusTimes;
  int _succeedFocusTimes;
  int _totalFocusTimes;
  double _averageFocusDuration;
  List<TimerRecordModel> _timerRecords;

  StatisticController() {
    _failedFocusTimes = 0;
    _succeedFocusTimes = 0;
    _totalFocusTimes = 0;
    _averageFocusDuration = 0;
  }

  Future<int> fetchTimerRecord({http.Client httpClient}) async {
    if (httpClient == null) {
      httpClient = http.Client();
    }

    int completed=0;
    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();

    var response = await httpClient.post(
        GlobalSettings.serverAddress + "getTimerRecordsForUser.php",
        body: map);

    if (response.statusCode == 200) {
      _timerRecords = List<TimerRecordModel>.from(json
          .decode(response.body)
          .map((tr) => TimerRecordModel.fromJson(tr)));

      _totalFocusTimes = _timerRecords != null ? _timerRecords.length : 0;
      _succeedFocusTimes = _failedFocusTimes = 0;
      _averageFocusDuration = 0;

      for (int i = 0; i < _timerRecords.length; i++) {
        if (_timerRecords[i].completed == 1) {
          completed++;
          _averageFocusDuration += _timerRecords[i].duration;
          ++_succeedFocusTimes;
        }
        else {
          ++_failedFocusTimes;
        }
      }
      _averageFocusDuration = completed == 0 ? _averageFocusDuration : _averageFocusDuration / completed;

      return _totalFocusTimes;
    }
    return 0;
  }

  List<TimerRecordModel> getTimerRecords(){
    return _timerRecords;
  }

  double getAverageFocusTimes(){
    return _averageFocusDuration;
  }

  int getTotalFocusTimes() {
    return _totalFocusTimes;
  }

  int getSucceedFocusTimes() {
    return _succeedFocusTimes;
  }

  int getSucceedPercentage() {
    if (_totalFocusTimes == 0) return 0;

    return _succeedFocusTimes * 100 ~/ _totalFocusTimes;
  }

  int getFailedFocusTimes() {
    return _failedFocusTimes;
  }

  int getFailedPercentage() {
    if (_totalFocusTimes == 0) return 0;

    return _failedFocusTimes * 100 ~/ _totalFocusTimes;
  }
}
