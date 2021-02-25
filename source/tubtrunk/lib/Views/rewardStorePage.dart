import 'package:flutter/material.dart';
import 'package:tubtrunk/Views/myCouponIcon.dart';

class RewardStorePage extends StatefulWidget {
  @override
  _RewardStorePageState createState() => _RewardStorePageState();
}

class _RewardStorePageState extends State<RewardStorePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.orangeAccent,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(MyCouponIcon.coupon,
                      size: 30.0, color: Colors.blueGrey.shade800),
                ),
                Tab(
                  icon: Icon(
                    Icons.my_library_music_outlined,
                    size: 30.0,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.pets_outlined,
                    size: 30.0,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.palette_outlined,
                    size: 30.0,
                    color: Colors.blueGrey.shade800,
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
                crossAxisCount: 1,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(100, (index) {
                  return Center(
                    child: Text('Reward $index'),
                  );
                }),
              ),
              GridView.count(
                crossAxisCount: 1,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(100, (index) {
                  return Center(
                    child: Text('Reward $index'),
                  );
                }),
              ),
              GridView.count(
                crossAxisCount: 1,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(100, (index) {
                  return Center(
                    child: Text('Reward $index'),
                  );
                }),
              ),
              GridView.count(
                crossAxisCount: 1,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(100, (index) {
                  return Center(
                    child: Text('Reward $index'),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
//    );;
  }
}
