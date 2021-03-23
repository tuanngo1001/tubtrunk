import 'package:tubtrunk/Models/userModel.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Initialization Test', () {
    test("The userModel instance should display all attributes correctly", () {
      UserModel firstTestUserModel = new UserModel("Duc Anh", "1234", "hot@hot", 100);
      expect(firstTestUserModel.name, "Duc Anh");
      expect(firstTestUserModel.password, "1234");
      expect(firstTestUserModel.email, "hot@hot");
      expect(firstTestUserModel.prize, 100);
    });

    test("The userModel.forNow instance should display all attributes correctly", () {
      UserModel secondTestUserModel = new UserModel.forNow(uID: 1, name: "Carlos", prize: 100, avgFocusTime: 20.0, totalFocusTime: 150, totalTimes: 200, totalPrize: 500);
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
      UserModel thirdTestUserModel = UserModel.fromJson(json);

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
