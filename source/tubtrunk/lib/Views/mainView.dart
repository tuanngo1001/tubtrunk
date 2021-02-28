import 'package:flutter/material.dart';
import 'MissionView.dart';
import 'AccountView.dart';
import 'timerView.dart';
import 'StatisticView.dart';
import 'RewardStoreView.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  final _pageOptions = [
    TimerView(mission: MissionView()),
    MissionView(),
    RewardStoreView(),
    StatisticView(),
    AccountView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  double money = 3000.0;
  static const double iconSize = 32.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Image.asset(
                'assets/TrunkCoinIcon.png',
                width: 35.0,
                height: 35.0,
              ),
              onPressed: () {}),
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 1),
            child: Center(
              child: Text(
                "$money",
                style: TextStyle(color: Colors.blueGrey[900], fontSize: 19.0),
              ),
            ),
          )
        ],
        backgroundColor: Colors.red,
        title: Text(
          'Tubtrunk',
          style: TextStyle(color: Colors.blueGrey[900]),
        ),
      ),
      body: Center(
        child: _pageOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15.0,
        unselectedFontSize: 12.0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer, size: iconSize),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech_outlined, size: iconSize),
            label: 'Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, size: iconSize),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart, size: iconSize),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, size: iconSize),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}