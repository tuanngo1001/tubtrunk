import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Utils/globalSettings.dart';
import '../Views/notificationView.dart';
import 'package:email_validator/email_validator.dart';
import '../Models/userModel.dart';
import 'memoryController.dart';

class AuthenticationController {
  Future<dynamic> login(context, String email, String password) async {
    email = email.trim();
    password = password.trim();
    if (!validateEmail(email) || !validatePassword(password)) {
      showDialog(
          context: context,
          builder: (_) => new NotificationView().emailPasswordWarning(context));
      return "Invalid input";
    } else {
      var map = new Map<String, String>();
      map['UserEmail'] = email;
      map['UserPassword'] = password;

      await http
          .post(GlobalSettings.serverAddress + "loginUser.php", body: map)
          .then((response) async {
        if (response.statusCode == 200) {
          if (response.body == "Not found") {
            showDialog(
                context: context,
                builder: (_) =>
                    new NotificationView().emailPasswordWarning(context));
            return "User not found";
          } else if (response.body == "Error") {
            showDialog(
                context: context,
                builder: (_) => new NotificationView().errorWarning(context));
            return "Error";
          } else {
            final userJson = jsonDecode(response.body).cast<String, dynamic>();
            GlobalSettings.user = UserModel.fromJson(userJson);
            await MemoryController.save('email', GlobalSettings.user.email);
            await MemoryController.save('token', GlobalSettings.user.token);
            showDialog(
                context: context,
                builder: (_) =>
                    new NotificationView().successLoginPopUp(context));
            return "Success";
          }
        } else {
          //status code == 404
          showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context));
          return "Error";
        }
      });
    }
  }

  static Future<String> rememberMe(context) async {
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
      var map = new Map<String, String>();
      map["UserEmail"] = email;
      map["UserToken"] = token;
      await http
          .post(GlobalSettings.serverAddress + "rememberMe.php", body: map)
          .then((response) async {
        if (response.statusCode == 200) {
          if (response.body == "Not found") {
            showDialog(
                context: context,
                builder: (_) => new NotificationView().autoLoginFail(context));
            returnMessage = "FAIL";
          } else if (response.body == "Error") {
            showDialog(
                context: context,
                builder: (_) => new NotificationView().errorWarning(context));
            returnMessage = "Error";
          } else {
            final userJson = jsonDecode(response.body).cast<String, dynamic>();
            GlobalSettings.user = UserModel.fromJson(userJson);
            returnMessage = "Success";
          }
        } else {
          //status code == 404
          showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context));
          returnMessage = "Error";
        }
      });
    }
    return returnMessage;
  }

  Future<dynamic> signup(context, String email, String password) async {
    email = email.trim();
    password = password.trim();
    if (!validateEmail(email) || !validatePassword(password)) {
      showDialog(
          context: context,
          builder: (_) => new NotificationView().emailPasswordWarning(context));
      return "Invalid input";
    } else {
      var map = new Map<String, String>();
      map["UserEmail"] = email;
      map["UserPassword"] = password;
      map["UserName"] = "New User"; //Default name, they can change it later.

      await http
          .post(GlobalSettings.serverAddress + "addNewUser.php", body: map)
          .then((response) {
        if (response.statusCode == 200) {
          if (response.body == "Invalid") {
            showDialog(
                context: context,
                builder: (_) =>
                    new NotificationView().userAlreadyExistWarning(context));
            return "Invalid user";
          } else if (response.body == "Success") {
            loginAfterSignup(context, email, password);
            return "Success";
          }
        } else {
          //status code == 404
          showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context));
          return "Error";
        }
      });
    }
  }

  Future<dynamic> loginAfterSignup(
      context, String email, String password) async {
    var map = new Map<String, String>();
    map['UserEmail'] = email;
    map['UserPassword'] = password;

    await http
        .post(GlobalSettings.serverAddress + "loginUser.php", body: map)
        .then((response) async {
      if (response.statusCode == 200) {
        if (response.body == "Not found") {
          showDialog(
              context: context,
              builder: (_) =>
                  new NotificationView().emailPasswordWarning(context));
          return "User not found";
        } else if (response.body == "Error") {
          showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context));
          return "Error";
        } else {
          final userJson = jsonDecode(response.body).cast<String, dynamic>();
          GlobalSettings.user = UserModel.fromJson(userJson);
          await MemoryController.save('email', GlobalSettings.user.email);
          await MemoryController.save('token', GlobalSettings.user.token);
          await MemoryController.save('username', GlobalSettings.user.username);
          showDialog(
              context: context,
              builder: (_) =>
                  new NotificationView().successSignUpPopUp(context));
          return "Success";
        }
      } else {
        //status code == 404
        showDialog(
            context: context,
            builder: (_) => new NotificationView().errorWarning(context));
        return "Error";
      }
    });
  }

  Future<dynamic> changeName(context, String userName) async {
    userName = userName.trim();
    if (userName.length == 0) {
      showDialog(
          context: context,
          builder: (_) => new NotificationView().missingName(context));
      return "Invalid input";
    } else {
      var map = new Map<String, String>();
      await MemoryController.read('email').then((email) {
        map["UserEmail"] = email;
      });
      map["UserName"] = userName;

      await http
          .post(GlobalSettings.serverAddress + "updateUserName.php", body: map)
          .then((response) async {
        print(response.body);
        if (response.statusCode == 200) {
          if (response.body == "Success") {
            await MemoryController.removeKey('username');
            await MemoryController.save('username', userName);
            NotificationView().changeNameSuccess(context);
            return "Success";
          } else if (response.body == "Existed") {
            showDialog(
                context: context,
                builder: (_) => new NotificationView().missingName(context));
            return "Username existed";
          } else {
            showDialog(
                context: context,
                builder: (_) => new NotificationView().missingName(context));
            return "Error";
          }
        } else {
          //status code == 404
          showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context));
          return "Error";
        }
      });
    }
  }

  Future logout(context) async {
    var map = new Map<String, String>();
    await MemoryController.read('token').then((token) {
      map["userToken"] = token;
    });

    await http
        .post(GlobalSettings.serverAddress + "logoutUser.php", body: map)
        .then((response) async {
      if (response.body == "Success") {
        await MemoryController.remove();
        NotificationView().logoutSuccess(context);
        return "Success";
      } else {
        showDialog(
            context: context,
            builder: (_) => new NotificationView().logoutFail(context));
        return "Error";
      }
    });
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
