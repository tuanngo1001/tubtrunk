import 'package:tubtrunk/Utils/globalSettings.dart';
import 'package:http/http.dart' as http;

class TimerController {
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
}
