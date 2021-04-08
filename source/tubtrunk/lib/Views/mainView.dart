import 'package:flutter/material.dart';
import 'package:tubtrunk/Utils/global_settings.dart';
import 'missionView.dart';
import 'accountView.dart';
import 'timerView.dart';
import 'statisticView.dart';
import 'rewardStoreView.dart';
import '../Controllers/mainController.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  MainController _mainController;

  TimerView timerView;
  MissionView missionView;
  RewardStoreView rewardStoreView;
  StatisticView statisticView;
  AccountView accountView;

  static const double iconSize = 32.5;

  @override
  initState() {
    super.initState();
    _mainController = MainController();
    _mainController.tabController = TabController(length: 5, vsync: this);

    missionView = MissionView();

    timerView = TimerView(updateProgressCallback: missionView.updateProgressCallback);
    rewardStoreView = RewardStoreView(updateMoney);

    statisticView = StatisticView();
    accountView = AccountView(resetTabItem);
  }

  void updateMoney(int newMoney){
    setState(() {
      GlobalSettings.user.money = newMoney;
    });
  }

  void resetTabItem(int index){
    setState(() {
      _mainController.changeMainView(index);
    });
  }

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
            padding: const EdgeInsets.only(left: 0.0, right: 10),
            child: Center(
              child: Text(
                GlobalSettings.user.money.toString(),
                key: Key("mvMoney"),
                style: TextStyle(color: Colors.blueGrey[900], fontSize: 19.0),
              ),
            ),
          )
        ],
        backgroundColor: Color(0xfff97c7c),
        title: Text(
          'Hi, ' + GlobalSettings.user.username,
          style: TextStyle(color: Colors.white),
          key: Key("mvGreetingUserName"),
        ),
      ),
      body: TabBarView(
        controller: _mainController.tabController,
        children: <Widget>[
          timerView,
          missionView,
          rewardStoreView,
          statisticView,
          accountView,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15.0,
        unselectedFontSize: 12.0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer, size: iconSize, key: Key("mvTimerBarItem")),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech_outlined,
                size: iconSize, key: Key("mvMissionBarItem")),
            label: 'Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined,
                size: iconSize, key: Key("mvStoreBarItem")),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart,
                size: iconSize, key: Key("stvStatBarItem")),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined,
                size: iconSize, key: Key("accvAccountBarItem")),
            label: 'Account',
          ),
        ],
        currentIndex: _mainController.selectedIndex,
        selectedItemColor: Color(0xfff97c7c),
        onTap: (int index) {
          setState(() {
            _mainController.changeMainView(index);
          });
        },
      ),
    );
  }
}
