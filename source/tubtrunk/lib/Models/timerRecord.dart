import 'dart:core';

class TimerRecord {
  String date;
  String time;
  int duration;
  int completed;
  String tag;

  TimerRecord({this.date, this.time, this.duration, this.completed, this.tag});

  factory TimerRecord.fromJson(Map<String, dynamic> json) {
    return TimerRecord(
      date: json['Date'],
      time: json['Time'],
      duration: int.parse(json['Duration']),
      completed: int.parse(json['Completed']),
      tag: json['Tag']
    );
  }
}