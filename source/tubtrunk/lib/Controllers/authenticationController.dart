import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "../Views/mainView.dart";
import 'package:tubtrunk/Utils/globalSettings.dart';

class AuthenticationController {
  String email = "";
  String password = "";

  void handleEmail(String input) {
    email = input;
  }

  void handlePassword(String input) {
    password = input;
  }

  void login() async {
    var map = new Map<String, String>();
    map['UserEmail'] = email;
    map['UserPassword'] = password;

    await http
        .post(GlobalSettings.serverAddress + "loginUser.php", body: map)
        .then((response) => {
              if (response.statusCode == 200)
                {
                  print("loginUser: " + response.body)
                }
            });
  }

  Future<dynamic> signup(String email, String password) async {
    try {
      var res = await http.post('', body: {
        'email': email,
        'password': password,
      });
      return res?.body;
    } finally {}
  }

  void deleteToken(String uEmail) async{
    var map = new Map<String,String>();
    map["UserEmail"] = uEmail;

    var response = await http.post(GlobalSettings.serverAddress+"logoutUser.php", body:map);
    print(response.body);
  }
}
