import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Models/timer_record_model.dart';

void main() {
  group('timerRecordModel initialization test', () {
    test('Testing instantiation with default contructor', () {
      TimerRecordModel model = TimerRecordModel(date: 'Thursday', time: '10pm', duration: 1000, completed: 1, tag: 'Test tag');
      expect(model.date, 'Thursday');
      expect(model.time, '10pm');
      expect(model.duration, 1000);
      expect(model.completed, 1);
      expect(model.tag, 'Test tag');
    });

    test('Testing instantiation with JSON constructor', () {
      var json = new Map<String, dynamic>();
      json['Date'] = 'Thursday';
      json['Time'] = '10pm';
      json['Duration'] = '1000';
      json['Completed'] = '1';
      json['Tag'] = 'Test tag';
      TimerRecordModel model = TimerRecordModel.fromJson(json);
      expect(model.date, 'Thursday');
      expect(model.time, '10pm');
      expect(model.duration, 1000);
      expect(model.completed, 1);
      expect(model.tag, 'Test tag');
    });

    test('Testing isCompleted()', () {
      // successful record
      TimerRecordModel model = TimerRecordModel(date: 'Thursday', time: '10pm', duration: 1000, completed: 1, tag: 'Test tag');
      expect(model.isCompleted(), "Success!");
      // failing record
      model = TimerRecordModel(date: 'Thursday', time: '10pm', duration: 1000, completed: 0, tag: 'Test tag');
      expect(model.isCompleted(), "Fail!");
    });
  });
}