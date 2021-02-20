
import 'package:flutter/material.dart';
void main() {
  runApp(TabsView());
}

class TabsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return rewardStore();
  }
}


class rewardStore extends StatefulWidget {
  @override
  _rewardStoreState createState() => _rewardStoreState();
}

class _rewardStoreState extends State<rewardStore> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "All",
                    style: TextStyle(
                      fontSize: 18.0,
                    )
                  ),

                ),
                Tab(
                  child: Text(
                    "In-Progress",
                    style: TextStyle(
                        fontSize:18.0,

                    )
                  ),
                ),
                Tab(
                  child: Text(
                    "Achieved",
                    style: TextStyle(
                        fontSize: 18.0,
                    )
                  ),
                )
              ],
            ),
            title: Text('Rewards Store', style: TextStyle( fontSize: 25.0,),),
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
      ),
    );
  }
}
