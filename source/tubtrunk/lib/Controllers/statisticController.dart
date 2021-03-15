import 'package:tubtrunk/Models/TimerRecordModel.dart';
import 'package:tubtrunk/Utils/GlobalSettings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatisticController {
  int _failedFocusTimes;
  int _succeedFocusTimes;
  int _totalFocusTimes;
  double _averageFocusTimes;
  List<TimerRecordModel> _timerRecords;

  StatisticController() {
    _failedFocusTimes = 0;
    _succeedFocusTimes = 0;
    _totalFocusTimes = 0;
    _averageFocusTimes=0;
  }

  Future<int> fetchTimerRecord() async {
    int completed=0;
    var map = new Map<String, String>();
    map["UserID"] = "1";

    var response = await http.post(
        GlobalSettings.serverAddress + "getTimerRecordsForUser.php",
        body: map);

    if (response.statusCode == 200) {
      _timerRecords = List<TimerRecordModel>.from(json
          .decode(response.body)
          .map((tr) => TimerRecordModel.fromJson(tr)));
      _totalFocusTimes = _timerRecords != null ? _timerRecords.length : 0;

      _succeedFocusTimes = _failedFocusTimes = 0;_averageFocusTimes=0;
      for (int i = 0; i < _timerRecords.length; i++) {
        if (_timerRecords[i].completed == 1) {
          completed++;
          _averageFocusTimes += _timerRecords[i].duration;
          if(i==_timerRecords.length-1){
            _averageFocusTimes=_averageFocusTimes/completed;
          }
          ++_succeedFocusTimes;
        }else
          ++_failedFocusTimes;
      }
      return _totalFocusTimes;
    }
    return 0;
  }



  List<TimerRecordModel> getTimerRecords(){
    return _timerRecords;
  }

  double getAverageFocusTimes(){
    return _averageFocusTimes;
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
