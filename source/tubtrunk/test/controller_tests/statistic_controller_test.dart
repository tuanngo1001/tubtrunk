import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tubtrunk/Controllers/statistic_controller.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tubtrunk/Utils/global_settings.dart';
import 'package:tubtrunk/Models/timer_record_model.dart';
import 'package:tubtrunk/Models/user_model.dart';
import 'controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test("Calculations after fetching records should be correct", () async {
    var controller = StatisticController();

    var jsonSuccessResponse =
        '[{"Date":"03\/24\/2021","Time":"00:45","Duration":"1","Completed":"1","Tag":null},'
        '{"Date":"03\/24\/2021","Time":"02:00","Duration":"1","Completed":"1","Tag":null},'
        '{"Date":"03\/24\/2021","Time":"02:03","Duration":"0","Completed":"0","Tag":null}]';

    var data = jsonDecode(jsonSuccessResponse);
    List<TimerRecordModel> expectedRecords = [];
    for (var key in data) {
      expectedRecords.add(TimerRecordModel.fromJson(key));
    }

    final client = MockClient();
    GlobalSettings.user = UserModel.forNow(uID: 1);
    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();

    // Succeed response
    when(client.post(GlobalSettings.serverAddress + "getTimerRecordsForUser.php", body: map))
        .thenAnswer((_) async => http.Response(jsonSuccessResponse, 200));

    expect(await controller.fetchTimerRecord(httpClient: client), 3);
    expect(listEquals(controller.getTimerRecords(), expectedRecords), true);
    expect(controller.getTotalFocusTimes(), 3);
    expect(controller.getSucceedFocusTimes(), 2);
    expect(controller.getFailedFocusTimes(), 1);
    expect(controller.getAverageFocusTimes(), 1);


    // Failed response
    when(client.post(GlobalSettings.serverAddress + "getTimerRecordsForUser.php", body: map))
        .thenAnswer((_) async => http.Response("", 400));

    expect(await controller.fetchTimerRecord(httpClient: client), 0);
  });
}

// Assume lengths of both list equal
bool listEquals(List<TimerRecordModel> list1, List<TimerRecordModel> list2) {
  for (int i = 0; i < list1.length; i++) {
    if (!recordEquals(list1[i], list2[i])) {
      return false;
    }
  }

  return true;
}

bool recordEquals(TimerRecordModel record1, TimerRecordModel record2) {
  if (record1.date != record2.date)
    return false;

  if (record1.time != record2.time)
    return false;

  if (record1.duration != record2.duration)
    return false;

  if (record1.completed != record2.completed)
    return false;

  return true;
}