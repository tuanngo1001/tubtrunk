import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Utils/globalSettings.dart';
import '../Views/notificationView.dart';

class AuthenticationController {
  Future<dynamic> login(context, String email, String password) async {
    if (email == "" || password == ""){
      showDialog(
        context: context,
        builder: (_) => new NotificationView().emailPasswordWarning(context));
    }
    else {
      var map = new Map<String, String>();
      map['UserEmail'] = email;
      map['UserPassword'] = password;

      await http.post(GlobalSettings.serverAddress + "loginUser.php", body: map)
        .then((response) => {
          if (response.statusCode == 200){
            if(response.body == "Not found"){
            showDialog(
              context: context,
              builder: (_) => new NotificationView().emailPasswordWarning(context))
            }
            else if(response.body == "Error"){
              showDialog(
                context: context,
                builder: (_) => new NotificationView().errorWarning(context))
            }
            else {
              showDialog(
                context: context,
                builder: (_) => new NotificationView().successLoginPopUp(context, email, response.body))
            }
          }
          else { //status code == 404
            showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context))
          }
        });
    }
  }

  Future<dynamic> signup(context, String email, String password) async {
    if (email == "" || password == ""){
      showDialog(
        context: context,
        builder: (_) => new NotificationView().emailPasswordWarning(context));
      }
    else {
      var map = new Map<String,String>();
      map["UserEmail"] = email;
      map["UserPassword"] = password;
      map["UserName"] = "User"; //Default name, they can change it later.

      await http.post(GlobalSettings.serverAddress+"addNewUser.php", body:map)
        .then((response) => {
          if (response.statusCode == 200) {
            if(response.body == "Already Exist"){
              showDialog(
                  context: context,
                  builder: (_) => new NotificationView().userAlreadyExistWarning(context))
            }
            else if(response.body == "Success"){
              loginAfterSignup(context, email, password)
            }         
          }
          else { //status code == 404
              showDialog(
                context: context,
                builder: (_) => new NotificationView().errorWarning(context))
          }
        });
    }
  }

  Future<dynamic> loginAfterSignup(context, String email, String password) async {
    var map = new Map<String, String>();
    map['UserEmail'] = email;
    map['UserPassword'] = password;

    await http.post(GlobalSettings.serverAddress + "loginUser.php", body: map)
      .then((response) => {
        if (response.statusCode == 200){
          if(response.body == "Not found"){
          showDialog(
            context: context,
            builder: (_) => new NotificationView().emailPasswordWarning(context))
          }
          else if(response.body == "Error"){
            showDialog(
              context: context,
              builder: (_) => new NotificationView().errorWarning(context))
          }
          else {
            showDialog(
                context: context,
                builder: (_) => new NotificationView().successSignUpPopUp(context, email, response.body))
          }
        }
        else { //status code == 404
          showDialog(
            context: context,
            builder: (_) => new NotificationView().errorWarning(context))
        }
      });
  }

  Future<dynamic> changeName(context, String userName) async {
    if (userName == "" || GlobalSettings.email == ""){
      showDialog(
        context: context,
        builder: (_) => new NotificationView().missingName(context));
      }
    else {
      var map = new Map<String, String>();
      map["UserEmail"] = GlobalSettings.email;
      map["UserName"] = userName;

      await http.post(GlobalSettings.serverAddress+"updateUserName.php", body:map)
        .then((response) => {
          if (response.statusCode == 200) {
            if (response.body == "Success"){
              NotificationView().changeNameSuccess(context, userName)
            }
            else if (response.body == "false"){
              showDialog(
                context: context,
                builder: (_) => new NotificationView().missingName(context))
            } 
            else {
              showDialog(
                context: context,
                builder: (_) => new NotificationView().missingName(context))
            }
          }
          else { //status code == 404
              showDialog(
                context: context,
                builder: (_) => new NotificationView().errorWarning(context))
          }
        });
    }
  }

  Future<dynamic> logout(context) async {
      var map = new Map<String, String>();
      map["UserEmail"] = GlobalSettings.email;

      await http.post(GlobalSettings.serverAddress+"logoutUser.php", body:map)
        .then((response) => {
          if (response.body == "Success"){
            NotificationView().logoutSuccess(context)
          }
          else {
            showDialog(
                context: context,
                builder: (_) => new NotificationView().logoutFail(context))
          }
        });
  }
}
