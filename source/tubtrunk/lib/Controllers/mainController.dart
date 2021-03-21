import 'package:flutter/material.dart';

class MainController {
  int _selectedIndex;
  int get selectedIndex => _selectedIndex;

  int _money;
  int get money => _money;

  TabController tabController;

  // Private constructor
  MainController._internal() {
    _selectedIndex = 0;
    _money = 3000;
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

  void addMoney(int amount) {
    _money += amount;
  }
}