import 'package:flutter/material.dart';
import 'package:tubtrunk/Utils/global_settings.dart';
import 'package:http/http.dart' as http;

class MainController {
  int _selectedIndex;
  int get selectedIndex => _selectedIndex;

  TabController tabController;

  // Private constructor
  MainController._internal() {
    _selectedIndex = 0;
  }

  // Singleton
  static MainController _instance;
  factory MainController() {
    if (_instance == null) {
      _instance = MainController._internal();
    }
    return _instance;
  }

  void changeMainView(int index) {
    _selectedIndex = index;
    tabController.animateTo(index);
  }

  void addMoney(int amount, {http.Client clientParameter}) async {
    GlobalSettings.user.money += amount;

    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();
    map["UserMoney"] = GlobalSettings.user.money.toString();

    http.Client client;
    if (clientParameter == null) {
      client = http.Client();
    } else {
      client = clientParameter;
    }

    await client.post(
        GlobalSettings.serverAddress + "updateUserMoney.php",
        body: map
    );
  }
}