import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/authentication_controller.dart';
import 'package:tubtrunk/Utils/global_settings.dart';
import 'package:tubtrunk/Models/user_model.dart';
import 'package:crypt/crypt.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'controller_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([http.Client])
void main() {
  MockBuildContext _mockContext;
  SharedPreferences.setMockInitialValues({});

  TestWidgetsFlutterBinding.ensureInitialized();
  group('authenticationController Tests:', () {
    test('login Test', () async {
      final authenticationController = AuthenticationController();
      final http.Client client = MockClient();

      String validEmail = "123@gmail.com";
      // String invalidEmail1 = ""; //Empty email
      // String invalidEmail2 = "notEmail"; //Wrong email format
      String validPassword = "1234";
      // String invalidPassword1 = ""; //Empty password
      // String invalidPassword2 = "4321";

      var map = new Map<String, String>();
      map['UserEmail'] = validEmail;
      map['UserPassword'] =
          Crypt.sha256(validPassword, salt: "tubtrunk").toString();

      var jsonSuccessResponse =
          '{"uID":"1","uEmail":"123@gmail.com","uUserName":"Tester","uPassword":"1234","uToken":"6059ef266bbea","uMoney":"100"}';

      var expectedResponse =
          '{"uID":"1","uEmail":"123@gmail.com","uUserName":"Tester","uPassword":"1234","uToken":"6059ef266bbea","uMoney":"100"}';
      var jsonExpectedResponse =
          jsonDecode(expectedResponse).cast<String, dynamic>();

      var expectedUser = UserModel.fromJson(jsonExpectedResponse);

      when(client.post(GlobalSettings.serverAddress + "loginUser.php",
              body: map))
          .thenAnswer((_) async => http.Response(jsonSuccessResponse, 200));

      await authenticationController
          .login(_mockContext, validEmail, validPassword, client: client);

      expect(GlobalSettings.user.email, expectedUser.email);
      expect(GlobalSettings.user.password, expectedUser.password);
      expect(GlobalSettings.user.uID, expectedUser.uID);
      expect(GlobalSettings.user.username, expectedUser.username);
      expect(GlobalSettings.user.token, expectedUser.token);
      expect(GlobalSettings.user.money, expectedUser.money);
    });
    test('rememberMe Test', () async {
      String validEmail = "123@gmail.com";
      String validToken = "6059ef266bbea";

      final http.Client client = MockClient();
      await SharedPreferences.getInstance().then((prefs) {
        prefs.setString("email", validEmail);
        prefs.setString("token", validToken);
      });

      var map = new Map<String, String>();
      map['UserEmail'] = validEmail;
      map['UserToken'] = validToken;

      var jsonSuccessResponse =
          '{"uID":"1","uEmail":"123@gmail.com","uUserName":"Tester","uPassword":"1234","uToken":"6059ef266bbea","uMoney":"100"}';

      var expectedResponse =
          '{"uID":"1","uEmail":"123@gmail.com","uUserName":"Tester","uPassword":"1234","uToken":"6059ef266bbea","uMoney":"100"}';
      var jsonExpectedResponse =
          jsonDecode(expectedResponse).cast<String, dynamic>();

      var expectedUser = UserModel.fromJson(jsonExpectedResponse);

      when(client.post(GlobalSettings.serverAddress + "rememberMe.php",
              body: map))
          .thenAnswer((_) async => http.Response(jsonSuccessResponse, 200));

      await AuthenticationController.rememberMe(_mockContext, client: client);

      expect(GlobalSettings.user.email, expectedUser.email);
      expect(GlobalSettings.user.password, expectedUser.password);
      expect(GlobalSettings.user.uID, expectedUser.uID);
      expect(GlobalSettings.user.username, expectedUser.username);
      expect(GlobalSettings.user.token, expectedUser.token);
      expect(GlobalSettings.user.money, expectedUser.money);
    });
    test('signup Test', () async {
      final authenticationController = AuthenticationController();
      String validEmail = "12345@gmail.com";
      String validPassword = "123456";

      final http.Client client = MockClient();

      await SharedPreferences.getInstance().then((prefs) {
        prefs.setString("email", validEmail);
        prefs.setString("password", validPassword);
      });

      var map = new Map<String, String>();
      map['UserEmail'] = validEmail;
      map["UserPassword"] =
          Crypt.sha256(validPassword, salt: "tubtrunk").toString();
      map["UserName"] = "New User";

      var successResponse = "Success";

      when(client.post(GlobalSettings.serverAddress + "addNewUser.php",
              body: map))
          .thenAnswer((_) async => http.Response(successResponse, 200));
      String expected = await authenticationController
          .signup(_mockContext, validEmail, validPassword, client: client);
      expect(expected, "Success");
    });
    test('loginAfterSignup Test', () async {
      final authenticationController = AuthenticationController();
      String validEmail = "123@gmail.com";
      String validPassword = "1234";

      final http.Client client = MockClient();

      var map = new Map<String, String>();
      map['UserEmail'] = validEmail;
      map["UserPassword"] =
          Crypt.sha256(validPassword, salt: "tubtrunk").toString();

      var jsonSuccessResponse =
          '{"uID":"1","uEmail":"123@gmail.com","uUserName":"Tester","uPassword":"1234","uToken":"6059ef266bbea","uMoney":"100"}';

      when(client.post(GlobalSettings.serverAddress + "loginUser.php",
              body: map))
          .thenAnswer((_) async => http.Response(jsonSuccessResponse, 200));
      String expected = await authenticationController.loginAfterSignup(
          _mockContext, validEmail, validPassword,
          client: client);
      expect(expected, "Success");
    });
    test('logout Test', () async {
      final authenticationController = AuthenticationController();
      String validToken = "6059ef266bbea";

      final http.Client client = MockClient();

      await SharedPreferences.getInstance().then((prefs) {
        prefs.setString("token", validToken);
      });

      var map = new Map<String, String>();
      map['UserToken'] = validToken;

      var successResponse = "Success";

      when(client.post(GlobalSettings.serverAddress + "logoutUser.php",
              body: map))
          .thenAnswer((_) async => http.Response(successResponse, 200));
      String expected =
          await authenticationController.logout(_mockContext, client: client);
      expect(expected, "Success");
    });
    test('changeName Test', () async {
      final authenticationController = AuthenticationController();
      String validEmail = "1234@gmail.com";
      String validUserName = "Tester";

      final http.Client client = MockClient();

      await SharedPreferences.getInstance().then((prefs) {
        prefs.setString("email", validEmail);
      });

      var map = new Map<String, String>();
      map["UserEmail"] = validEmail;
      map["UserName"] = validUserName;

      var successResponse = "Success";

      when(client.post(GlobalSettings.serverAddress + "updateUserName.php",
              body: map))
          .thenAnswer((_) async => http.Response(successResponse, 200));
      String expected = await authenticationController
          .changeName(_mockContext, validUserName, client: client);
      expect(expected, "Success");
    });
  });
  group('Validate input Tests', () {
    test('email validation test', () {
      final authenticationController = AuthenticationController();

      String validEmail = "123@gmail.com";
      String invalidEmail1 = ""; //Empty email
      String invalidEmail2 = "notEmail"; //Wrong email format

      expect(authenticationController.validateEmail(validEmail), true);
      expect(authenticationController.validateEmail(invalidEmail1), false);
      expect(authenticationController.validateEmail(invalidEmail2), false);
    });
    test('password validation test', () {
      final authenticationController = AuthenticationController();

      String validPassword = "12345";
      String invalidPassword1 = ""; //Empty password
      String invalidPassword2 = "432"; //Wrong length password

      expect(authenticationController.validatePassword(validPassword), true);
      expect(
          authenticationController.validatePassword(invalidPassword1), false);
      expect(
          authenticationController.validatePassword(invalidPassword2), false);
    });
  });
}
