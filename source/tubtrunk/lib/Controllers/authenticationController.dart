import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Views/notificationView.dart';
import 'package:email_validator/email_validator.dart';

class AuthenticationController {
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
        .then((response) {
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
              save('email', email);
              save('password', password);
              save('token', response.body);
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
      map["UserName"] = "User"; //Default name, they can change it later.

      await http.post(GlobalSettings.serverAddress+"addNewUser.php", body:map)
        .then((response) {
          if (response.statusCode == 200) {
            if(response.body == "Already Exist"){
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
      .then((response) {
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
            save('email', email);
            save('password', password);
            save('token', response.body);
            save('username', 'User');
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
      await read('email').then((email) {
        map["UserEmail"] = email;
      });
      map["UserName"] = userName;

      await http.post(GlobalSettings.serverAddress+"updateUserName.php", body:map)
        .then((response) {
          print(response.body);
          if (response.statusCode == 200) {
            if (response.body == "Success"){
              save('username', userName);
              NotificationView().changeNameSuccess(context);
            }
            else if (response.body == "false"){
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

  Future<dynamic> logout(context) async {
      var map = new Map<String, String>();
      await read('email').then((email) {
        map["UserEmail"] = email;
      });

      await http.post(GlobalSettings.serverAddress+"logoutUser.php", body:map)
        .then((response) {
          if (response.body == "Success"){
            remove();
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

  void save(String inputKey, String inputValue) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString(inputKey, inputValue) ;
      print('saved $inputKey: $inputValue.');
    });
  }

  Future<String> read(String inputKey) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(inputKey) ?? "";
    print('read $inputKey: $value.');
    return value;
  }

  void remove() async {
    await SharedPreferences.getInstance().then((prefs) {
      // prefs.remove(inputKey);
      prefs.clear();
      print('cleared local memory.');
    });
  }
}
