import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/leaderboardController.dart';
import 'package:tubtrunk/Models/leaderboardModel.dart';
import 'package:tubtrunk/Views/Icons/rankingIcon.dart';

class LeaderboardView extends StatefulWidget {
  final LeaderboardController _leaderboardController = LeaderboardController();
  @override
  _LeaderboardViewState createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  Future<void> _showMyDialog(
      int index, List<LeaderboardModel> usersList) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.orange.shade300,
          insetPadding: EdgeInsets.all(0),
          title: Text("${usersList[index].name}'s Achievement",
              key: Key("${index + 1}st userAchievement")),
          content: SingleChildScrollView(
            child:
                ListBody(children: _generateUserAchievements(index, usersList)),
          ),
        );
      },
    );
  }

  List<Widget> _generateUserAchievements(
      int index, List<LeaderboardModel> usersList) {
    return <Widget>[
      Text(
          "Average focus time: ${double.parse(usersList[index].avgFocusTime.toStringAsFixed(2))} min(s)",
          style: TextStyle(color: Colors.black87, fontSize: 17.0)),
      SizedBox(height: 1.5),
      Text("Total focus time: ${usersList[index].totalFocusTime} min(s)",
          style: TextStyle(color: Colors.black87, fontSize: 17.0)),
      SizedBox(height: 1.5),
      Text("Successful focus sessions: ${usersList[index].totalTimes} time(s)",
          style: TextStyle(color: Colors.black87, fontSize: 17.0)),
      SizedBox(height: 1.5),
      RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            TextSpan(
                text: "Prize money from mission(s): ",
                style: TextStyle(color: Colors.black87, fontSize: 17.0)),
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset(
                  'assets/TrunkCoinIcon.png',
                  width: 17.0,
                  height: 17.0,
                ),
              ),
            ),
            TextSpan(
                text: "${usersList[index].totalPrize}",
                style: TextStyle(color: Colors.black87, fontSize: 17.0)),
          ],
        ),
      ),
      SizedBox(height: 1.5),
      RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          children: [
            TextSpan(
                text: "Current money amount: ",
                style: TextStyle(color: Colors.black87, fontSize: 17.0)),
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset(
                  'assets/TrunkCoinIcon.png',
                  width: 18.0,
                  height: 18.0,
                ),
              ),
            ),
            TextSpan(
                text: '${usersList[index].prize}',
                style: TextStyle(color: Colors.black87, fontSize: 17.0))
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: Color(0xfff97c7c),
      ),
      body: SafeArea(
        child: FutureBuilder<ListView>(
          future: _getDataAndReturnListView(),
          builder: (BuildContext context, AsyncSnapshot<ListView> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            } else {
              return Container(width: 0.0, height: 0.0);
            }
          },
        ),
      ),
    );
  }

  BoxDecoration _highLightTopThree(int index) {
    if (index == 0) {
      return BoxDecoration(
          borderRadius: new BorderRadius.circular(12.0),
          color: Colors.yellow.shade700);
    } else if (index == 1) {
      return new BoxDecoration(
          borderRadius: new BorderRadius.circular(12.0),
          color: Colors.grey.shade500);
    } else if (index == 2) {
      return new BoxDecoration(
          borderRadius: new BorderRadius.circular(12.0),
          color: Colors.brown.shade700);
    } else {
      return new BoxDecoration(
          borderRadius: new BorderRadius.circular(12.0),
          color: Colors.grey.shade300);
    }
  }

  Icon _highlightTopThreeBadges(int index) {
    if (index == 0) {
      return Icon(
        RankIcon.ribbon_award_with_star_shape,
        size: 30.0,
        color: Colors.yellowAccent.shade400,
      );
    } else if (index == 1) {
      return Icon(
        RankIcon.ribbon_award_with_star_shape,
        size: 30.0,
        color: Colors.grey,
      );
    } else if (index == 2) {
      return Icon(
        RankIcon.ribbon_award_with_star_shape,
        size: 30.0,
        color: Colors.brown,
      );
    } else {
      return Icon(
        RankIcon.ribbon_award_with_star_shape,
        size: 30.0,
        color: Colors.black54,
      );
    }
  }

  Future<ListView> _getDataAndReturnListView() async {
    List<LeaderboardModel> usersList =
        await widget._leaderboardController.fetchAllUsers();
    return ListView.builder(
        key: Key("userList"),
        padding: const EdgeInsets.all(2),
        itemCount: usersList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: _highLightTopThree(index),
            child: GestureDetector(
              onTap: () => _showMyDialog(index, usersList),
              child: Card(
                key: Key("${index + 1}st cardButton"),
                color: Colors.cyan.shade50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        child: ListTile(
                      leading: _highlightTopThreeBadges(index),
                      title: Transform.translate(
                        offset: Offset(-25, 0),
                        child: Text('${index + 1}',
                            style: TextStyle(fontSize: 20.0)),
                      ),
                    )),
                    Expanded(
                        child: ListTile(
                      title: Text(
                        "${usersList[index].name}",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                        key: Key('${index + 1}th username'),
                      ),
                    )),
                    Expanded(
                        child: ListTile(
                      trailing: Text('${usersList[index].totalFocusTime}',
                          style: TextStyle(fontSize: 18)),
                      title: Transform.translate(
                        offset: Offset(15, 0),
                        child: Icon(
                          Icons.av_timer_outlined,
                          size: 25.0,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
