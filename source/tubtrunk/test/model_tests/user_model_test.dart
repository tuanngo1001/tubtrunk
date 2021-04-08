import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Models/user_model.dart';

void main() {
  group('Initialization Test', () {
    test("The user instance should display every data correctly", () {
      //Act
      UserModel testUser = UserModel(
          "Tester", "password", "email@gmail.com", "abcdxyz1234", 100);
      //Assert
      expect(testUser.username, "Tester");
      expect(testUser.password, "password");
      expect(testUser.email, "email@gmail.com");
      expect(testUser.token, "abcdxyz1234");
      expect(testUser.money, 100);
    });
  });

  group('Function Test', () {
    test("The user .fromJson should display all attributes correctly", () {
      //Arrange
      var json = new Map<String, dynamic>();
      json['uID'] = '1';
      json['uEmail'] = 'email@gmail.com';
      json['uUserName'] = 'Tester';
      json['uPassword'] = 'password';
      json['uToken'] = 'abcdxyz1234';
      json['uMoney'] = '100';

      //Act
      var testUser = UserModel.fromJson(json);
      //Assert
      expect(testUser.uID, 1);
      expect(testUser.username, "Tester");
      expect(testUser.password, "password");
      expect(testUser.email, "email@gmail.com");
      expect(testUser.token, "abcdxyz1234");
      expect(testUser.money, 100);
    });
  });
}
