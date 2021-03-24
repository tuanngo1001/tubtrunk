import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Utils/globalSettings.dart';
import '../Views/notificationView.dart';
import 'package:email_validator/email_validator.dart';
import '../Models/userModel.dart';
import 'memoryController.dart';

class AuthenticationController {
  static UserModel user;

  Future<dynamic> login(context, String email, String password) async {
    email = email.trim();
    password = password.trim();
    if (!validateEmail(email) || !validatePassword(password)){
      showDialog(
        context: context,
        builder: (_) => new NotificationView().emailPasswordWarning(context));
    }
    else {
      var map = new Map<String, String>();
      map['UserEmail'] = email;
      map['UserPassword'] = password;

      await http.post(GlobalSettings.serverAddress + "loginUser.php", body: map)
        .then((response) async {
          if (response.statusCode == 200){
            if(response.body == "Not found"){
            showDialog(
              context: context,
              builder: (_) => new NotificationView().emailPasswordWarning(context));
            }
            else if(response.body == "Error"){
              showDialog(
                context: context,
                builder: (_) => new NotificationView().errorWarning(context));
            }
            else {
              final userJson = jsonDecode(response.body).cast<String, dynamic>();
              user = UserModel.fromJson(userJson);
              await MemoryController.save('email', user.email);
              await MemoryController.save('token', user.token);
              showDialog(
                context: context,
                builder: (_) => new NotificationView().successLoginPopUp(context));
            }
          }
          else { //status code == 404
            showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context));
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

    if (email == "" || token == ""){
      returnMessage = "FAIL";
    }
    else {
      var map = new Map<String, String>();
      map["UserEmail"] = email;
      map["UserToken"] = token;
      await http.post(GlobalSettings.serverAddress + "rememberMe.php", body: map)
        .then((response) async {
          if (response.statusCode == 200){
            if(response.body == "Not found") {
              returnMessage = "FAIL - Not found";
            }
            else if(response.body == "Error"){
              returnMessage = "FAIL - Error";
            }
            else {
              final userJson = jsonDecode(response.body).cast<String, dynamic>();
              user = UserModel.fromJson(userJson);
              returnMessage = "Success";
            }
          }
          else { //status code == 404
            returnMessage = "FAIL - Error 404";
          }
      });
    }
    return returnMessage;
  }

  Future<dynamic> signup(context, String email, String password) async {
    email = email.trim();
    password = password.trim();
    if (!validateEmail(email) || !validatePassword(password)){
      showDialog(
        context: context,
        builder: (_) => new NotificationView().emailPasswordWarning(context));
      }
    else {
      var map = new Map<String, String>();
      map["UserEmail"] = email;
      map["UserPassword"] = password;
      map["UserName"] = "New User"; //Default name, they can change it later.

      await http.post(GlobalSettings.serverAddress+"addNewUser.php", body:map)
        .then((response) {
          if (response.statusCode == 200) {
            if(response.body == "Invalid"){
              showDialog(
                  context: context,
                  builder: (_) => new NotificationView().userAlreadyExistWarning(context));
            }
            else if(response.body == "Success"){
              loginAfterSignup(context, email, password);
            }         
          }
          else { //status code == 404
              showDialog(
                context: context,
                builder: (_) => new NotificationView().errorWarning(context));
          }
        });
    }
  }

  Future<dynamic> loginAfterSignup(context, String email, String password) async {
    var map = new Map<String, String>();
    map['UserEmail'] = email;
    map['UserPassword'] = password;

    await http.post(GlobalSettings.serverAddress + "loginUser.php", body: map)
      .then((response) async {
        if (response.statusCode == 200){
          if(response.body == "Not found"){
            showDialog(
              context: context,
              builder: (_) => new NotificationView().emailPasswordWarning(context));
          }
          else if(response.body == "Error"){
            showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context));
          }
          else {
            final userJson = jsonDecode(response.body).cast<String, dynamic>();
            user = UserModel.fromJson(userJson);
            await MemoryController.save('email', user.email);
            await MemoryController.save('token', user.token);
            await MemoryController.save('username', user.username);
            showDialog(
                context: context,
                builder: (_) => new NotificationView().successSignUpPopUp(context));
          }
        }
        else { //status code == 404
          showDialog(
            context: context,
            builder: (_) => new NotificationView().errorWarning(context));
        }
      });
  }

  Future<dynamic> changeName(context, String userName) async {
    if (userName.length == 0){
      showDialog(
        context: context,
        builder: (_) => new NotificationView().missingName(context));
      }
    else {
      var map = new Map<String, String>();
      await MemoryController.read('email').then((email) {
        map["UserEmail"] = email;
      });
      map["UserName"] = userName;

      await http.post(GlobalSettings.serverAddress+"updateUserName.php", body:map)
        .then((response) async {
          print(response.body);
          if (response.statusCode == 200) {
            if (response.body == "Success"){
              await MemoryController.removeKey('username');
              await MemoryController.save('username', userName);
              NotificationView().changeNameSuccess(context);
            }
            else if (response.body == "Existed"){
              showDialog(
                context: context,
                builder: (_) => new NotificationView().missingName(context));
            } 
            else {
              showDialog(
                context: context,
                builder: (_) => new NotificationView().missingName(context));
            }
          }
          else { //status code == 404
              showDialog(
                context: context,
                builder: (_) => new NotificationView().errorWarning(context));
          }
        });
    }
  }

  Future logout(context) async {
      var map = new Map<String, String>();
      await MemoryController.read('token').then((token) {
        map["userToken"] = token;
      });

      await http.post(GlobalSettings.serverAddress+"logoutUser.php", body:map)
        .then((response) async {
          if (response.body == "Success"){
            await MemoryController.remove();
            NotificationView().logoutSuccess(context);
          }
          else {
            showDialog(
                context: context,
                builder: (_) => new NotificationView().logoutFail(context));
          }
        });
  }

  bool validateEmail(String email) {
    if (email.length > 0) {
      if (EmailValidator.validate(email))
        return true;
      else 
        return false;
    } 
    else return false;
  }

  bool validatePassword(String password){
    //Add more constrain with password if needed
    if (password.length >= 4) {
      return true;
    }
    else
      return false;
  }
}
