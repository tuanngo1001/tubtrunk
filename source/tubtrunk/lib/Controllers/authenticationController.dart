import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'package:tubtrunk/Views/notificationView.dart';
import 'package:tubtrunk/Models/userModel.dart';
import 'memoryController.dart';

class AuthenticationController {
  Future<String> login(context, String email, String password,
      {http.Client client}) async {
    String returnMessage = "";
    email = email.trim();
    password = password.trim();
    if (!validateEmail(email) || !validatePassword(password)) {
      returnMessage = "Invalid input";
    } else {
      var map = new Map<String, String>();
      map['UserEmail'] = email;
      map['UserPassword'] = password;

      if (client == null) {
        client = http.Client();
      }

      await client
          .post(GlobalSettings.serverAddress + "loginUser.php", body: map)
          .then((response) async {
        if (response.statusCode == 200) {
          if (response.body == "Not found") {
            returnMessage = "User not found";
          } else if (response.body == "Error") {
            returnMessage = "Error";
          } else {
            final userJson = jsonDecode(response.body).cast<String, dynamic>();
            GlobalSettings.user = UserModel.fromJson(userJson);
            await MemoryController.save('email', GlobalSettings.user.email);
            await MemoryController.save('token', GlobalSettings.user.token);

            returnMessage = "Success";
          }
        } else {
          //status code == 404
          returnMessage = "Error";
        }
      });
    }
    return returnMessage;
  }

  static Future<String> rememberMe(context, {http.Client client}) async {
    String email, token;
    String returnMessage = "";
    await MemoryController.read("email").then((ret) {
      email = ret;
    });
    await MemoryController.read("token").then((ret) {
      token = ret;
    });

    if (email == "" || token == "") {
      returnMessage = "FAIL";
    } else {
      if (client == null) {
        client = http.Client();
      }
      var map = new Map<String, String>();
      map["UserEmail"] = email;
      map["UserToken"] = token;

      await client
          .post(GlobalSettings.serverAddress + "rememberMe.php", body: map)
          .then((response) async {
        if (response.statusCode == 200) {
          if (response.body == "Not found") {
            returnMessage = "FAIL - Not found";
          } else if (response.body == "Error") {
            returnMessage = "FAIL - Error";
          } else {
            final userJson = jsonDecode(response.body).cast<String, dynamic>();
            GlobalSettings.user = UserModel.fromJson(userJson);
            returnMessage = "Success";
          }
        } else {
          //status code == 404
          returnMessage = "FAIL - Error 404";
        }
      });
    }
    return returnMessage;
  }

  Future<String> signup(context, String email, String password,
      {http.Client client}) async {
    String returnMessage = "";
    email = email.trim();
    password = password.trim();
    if (!validateEmail(email) || !validatePassword(password)) {
      returnMessage = "Invalid input";
    } else {
      if (client == null) {
        client = http.Client();
      }
      var map = new Map<String, String>();
      map["UserEmail"] = email;
      map["UserPassword"] = password;
      map["UserName"] = "New User"; //Default name, they can change it later.

      await client
          .post(GlobalSettings.serverAddress + "addNewUser.php", body: map)
          .then((response) {
        if (response.statusCode == 200) {
          if (response.body == "Invalid") {
            returnMessage = "Invalid user";
          } else if (response.body == "Success") {
            returnMessage = "Success";
          }
        } else {
          //status code == 404
          returnMessage = "Error";
        }
      });
    }
    return returnMessage;
  }

  Future<String> loginAfterSignup(context, String email, String password,
      {http.Client client}) async {
    String returnMessage = "";
    var map = new Map<String, String>();
    map['UserEmail'] = email;
    map['UserPassword'] = password;
    if (client == null) {
      client = http.Client();
    }
    await client
        .post(GlobalSettings.serverAddress + "loginUser.php", body: map)
        .then((response) async {
      if (response.statusCode == 200) {
        if (response.body == "Not found") {
          returnMessage = "User not found";
        } else if (response.body == "Error") {
          returnMessage = "Error";
        } else {
          final userJson = jsonDecode(response.body).cast<String, dynamic>();
          GlobalSettings.user = UserModel.fromJson(userJson);
          await MemoryController.save('email', GlobalSettings.user.email);
          await MemoryController.save('token', GlobalSettings.user.token);
          await MemoryController.save('username', GlobalSettings.user.username);

          returnMessage = "Success";
        }
      } else {
        //status code == 404
        returnMessage = "Error";
      }
    });
    return returnMessage;
  }

  Future<String> changeName(context, String userName,
      {http.Client client}) async {
    String returnMessage = "";
    userName = userName.trim();
    if (userName.length == 0) {
      returnMessage = "Invalid input";
    } else {
      var map = new Map<String, String>();
      await MemoryController.read('email').then((email) {
        map["UserEmail"] = email;
      });
      map["UserName"] = userName;
      if (client == null) {
        client = http.Client();
      }
      await client
          .post(GlobalSettings.serverAddress + "updateUserName.php", body: map)
          .then((response) async {
        print(response.body);
        if (response.statusCode == 200) {
          if (response.body == "Success") {
            await MemoryController.removeKey('username');
            await MemoryController.save('username', userName);
            GlobalSettings.user.username = userName;
            returnMessage = "Success";
          } else if (response.body == "Existed") {
            returnMessage = "Username existed";
          } else {
            returnMessage = "Error";
          }
        } else {
          //status code == 404
          returnMessage = "Error";
        }
      });
    }
    return returnMessage;
  }

  Future<String> logout(context, {http.Client client}) async {
    String returnMessage = "";
    var map = new Map<String, String>();
    await MemoryController.read('token').then((token) {
      map["userToken"] = token;
    });
    if (client == null) {
      client = http.Client();
    }
    await client
        .post(GlobalSettings.serverAddress + "logoutUser.php", body: map)
        .then((response) async {
      if (response.body == "Success") {
        await MemoryController.remove();
        returnMessage = "Success";
      } else {
        returnMessage = "Error";
      }
    });
    return returnMessage;
  }

  bool validateEmail(String email) {
    if (email.length > 0) {
      if (EmailValidator.validate(email))
        return true;
      else
        return false;
    } else
      return false;
  }

  bool validatePassword(String password) {
    //Add more constrain with password if needed
    if (password.length >= 4) {
      return true;
    } else
      return false;
  }
}
