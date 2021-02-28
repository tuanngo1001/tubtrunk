import 'dart:core';

class TimerRecordModel {
  String date;
  String time;
  int duration;
  int completed;
  String tag;

  TimerRecordModel(
      {this.date, this.time, this.duration, this.completed, this.tag});

  factory TimerRecordModel.fromJson(Map<String, dynamic> json) {
    return TimerRecordModel(
        date: json['Date'],
        time: json['Time'],
        duration: int.parse(json['Duration']),
        completed: int.parse(json['Completed']),
        tag: json['Tag']);
  }
}
