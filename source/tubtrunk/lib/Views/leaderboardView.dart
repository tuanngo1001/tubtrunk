import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/leaderboardController.dart';
import 'package:tubtrunk/Models/userModel.dart';
import 'package:tubtrunk/Views/rankingIcon.dart';

class LeaderboardView extends StatefulWidget {
  @override
  _LeaderboardViewState createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  final LeaderboardController _leaderboardController = LeaderboardController();
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Player Achievement'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Completed missions'),
                Text("Minutes of focus and Avg time"),
                Text("Success/fail pie chart")
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
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

  Future<ListView> _getDataAndReturnListView() async {
    List<UserModel> usersList = await _leaderboardController.fetchAllUsers();
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: usersList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: GestureDetector(
              onTap: _showMyDialog,
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            RankIcon.ribbon_award_with_star_shape,
                            size: 30.0,
                            color: Colors.black54,
                          ),
                          title: Transform.translate(
                            offset: Offset(-25, 0),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 3,
                        child: ListTile(
                          title: Text(
                            "${usersList[index].name}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: ListTile(
                          trailing: Text('${usersList[index].prize}',
                              style: TextStyle(fontSize: 18)),
                          title: Transform.translate(
                            offset: Offset(22, 0),
                            child: Image.asset('assets/TrunkCoinIcon.png',
                                width: 20.0, height: 20.0),
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
