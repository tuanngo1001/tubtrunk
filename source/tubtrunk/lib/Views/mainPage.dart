
import 'package:flutter/material.dart';
import 'missionPage.dart';
import 'accountPage.dart';
import 'timerPage.dart';
import 'rewardStorePage.dart';


void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
//  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final _pageOptions = [
    TimerPage(),
    MissionPage(),
    RewardStorePage(),
    AccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  double money=3000.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[
          IconButton(
            icon: Icon(
              Icons.euro,
              color: Colors.black,
              size: 24.0,
            ),
            onPressed: (){
            }
          ),
          Center(
            child: Text(
              "$money",
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 20.0
              ),
            ),
          )
        ],
        backgroundColor: Colors.red,
        title:  Text(
          'Tubtrunk',
          style: TextStyle(
              color: Colors.blueGrey[900]
          ),
        ),
      ),
      body: Center(
        child: _pageOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 18.0,
        unselectedFontSize: 15.0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer, size: 35.0,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech_outlined, size: 35.0),
            label: 'Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, size: 35.0),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, size: 35.0),
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
