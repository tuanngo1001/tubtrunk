import 'package:tubtrunk/Models/leaderboardModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Initialization Test', () {
    test("The userModel.forNow instance should display all attributes correctly", () {
      LeaderboardModel secondTestUserModel = new LeaderboardModel(uID: 1, name: "Carlos", prize: 100, avgFocusTime: 20.0, totalFocusTime: 150, totalTimes: 200, totalPrize: 500);
      expect(secondTestUserModel.uID, 1);
      expect(secondTestUserModel.name, "Carlos");
      expect(secondTestUserModel.prize, 100);
      expect(secondTestUserModel.avgFocusTime, 20.0);
      expect(secondTestUserModel.totalFocusTime, 150);
      expect(secondTestUserModel.totalTimes, 200);
      expect(secondTestUserModel.totalPrize, 500);
    });

    test("The userModel.fromJson should not be null and it should be displaying all the attributes correctly", () {
      var json = new Map<String, dynamic>();
      json['ID'] = 1;
      json['UserName'] = "Duc Anh";
      json['Prize'] = 100;
      json['AverageMinutes'] = 20.0;
      json['TotalMinutes'] = 200;
      json['TotalTimes'] = 300;
      json['TotalPrize'] = 1000;
      LeaderboardModel thirdTestUserModel = LeaderboardModel.fromJson(json);

      expect(thirdTestUserModel.uID, 1);
      expect(thirdTestUserModel.name, "Duc Anh");
      expect(thirdTestUserModel.prize, 100);
      expect(thirdTestUserModel.avgFocusTime, 20.0);
      expect(thirdTestUserModel.totalFocusTime, 200);
      expect(thirdTestUserModel.totalTimes, 300);
      expect(thirdTestUserModel.totalPrize, 1000);
    });
  });
}
