import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:tubtrunk/Controllers/timerController.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'timer_controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('TimerController tests', () {
    test('Testing initialization of timer controller', () {
      final timerController = TimerController();
      expect(timerController.duration, 5); // default duration set in controller class
      expect(timerController.stopped, true);
      expect(timerController.resumable, false);
      expect(timerController.finished, false);
    });

    test('Testing starting of timer', () {
      final timerController = TimerController();
      timerController.onStart();
      expect(timerController.resumable, true);
      expect(timerController.finished, false);
    });

    test('Testing saving to database', () async {
      final timerController = TimerController();
      timerController.updateStartDateTime();
      final http.Client client = MockClient();

      var map = new Map<String, String>();
      map["UserID"] = "1";
      map["Date"] = GlobalSettings.dateFormatted.format(DateTime.now());
      map["Time"] = GlobalSettings.timeFormatted.format(DateTime.now());
      map["Duration"] = "0";
      map["Completed"] = "0";

      // send request to mock client, nothing should happen when record saves successfully
      when(client.post(GlobalSettings.serverAddress + "addTimerRecord.php", body: map)).thenAnswer((_) async => http.Response('Success', 200));
      timerController.saveTimerRecord(clientParameter: client);

      // send request to mock client, throws exception when fails to save new record
      when(client.post(GlobalSettings.serverAddress + "addTimerRecord.php", body: map)).thenAnswer((_) async => http.Response('Not found', 404));
      expect(timerController.saveTimerRecord(clientParameter: client), throwsException);
    });
  });
}