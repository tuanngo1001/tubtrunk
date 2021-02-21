
import 'package:flutter/material.dart';
//void main() {
//  runApp(TabsView());
//}
//
//class TabsView extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MissionPage();
//  }
//}


class MissionPage extends StatefulWidget {
  @override
  _MissionPageState createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.orangeAccent,
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "All",
                      style: TextStyle(
                        fontSize: 18.0,
                          color: Colors.blueGrey.shade900
                      )
                    ),

                  ),
                  Tab(
                    child: Text(
                      "In-Progress",
                      style: TextStyle(
                          fontSize:18.0,
                          color: Colors.blueGrey.shade900

                      )
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Achieved",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey.shade900
                      )
                    ),
                  )
                ],
              ),
//            title: Text('Rewards Store', style: TextStyle( fontSize: 25.0,),),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(100, (index) {
                    return Center(
                      child: Text(
                          'Reward $index'
                      ),
                    );
                  }),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(100, (index) {
                    return Center(
                      child: Text(
                          'Reward $index'
                      ),
                    );
                  }),
                ),

                GridView.count(
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(100, (index) {
                    return Center(
                      child: Text(
                          'Reward $index'
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
//    );
  }
}
