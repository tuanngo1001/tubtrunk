import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/mainController.dart';
import 'package:tubtrunk/Controllers/music_controller.dart';
import 'package:tubtrunk/Controllers/storeController.dart';
import 'package:tubtrunk/Views/Icons/myCouponIcon.dart';

class RewardStoreView extends StatefulWidget {
  @override
  _RewardStoreViewState createState() => _RewardStoreViewState();
}

class _RewardStoreViewState extends State<RewardStoreView> {
  StoreController controller;
  MainController _mainController;

  @override
  void initState() {
    controller = new StoreController();
    _mainController = new MainController();
    super.initState();
  }

  void removeCouponSetState(int index) {
    setState(() {
      //For now only remove coupon at given index, add more functions if needed.
      // controller.removeCouponAtIndex(index);
      controller.couponList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.indigo.shade100,
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
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(
              future: controller.loadCouponList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text('ERROR: ${snapshot.error.toString()}'));
                } else if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return TabBarView(
                  children: [
                    _buildCouponList(),
                    _buildMusicList()
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _buildCouponList() {
    return GridView.count(
      childAspectRatio: 2.5,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      crossAxisCount: 1,
      // Generate 100 widgets that display their index in the List.
      children:
      List.generate(controller.couponList.length, (index) {
        return Card(
          color: Colors.cyan.shade50,
          child: InkWell(
            splashColor: Colors.cyanAccent,
            hoverColor: Colors.lightBlue[100],
            onTap: () => controller.buyCoupon(int.parse(controller.couponList[index].price), index, context),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(18.0)),
                  Text(
                    controller.couponList[index].store + " Coupon",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  Text(
                    controller.couponList[index].description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/TrunkCoinIcon.png',
                        width: 28.0,
                        height: 28.0,
                      ),
                      Padding(padding: EdgeInsets.all(2.5)),
                      Text(
                        controller.couponList[index].price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      )
                    ],
                  ),
                ],
              )
            )
          ),
        );
      }),
    );
  }

  Widget _buildMusicList() {
    int musicPrice = 35;
    return GridView.count(
      childAspectRatio: 3.0,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      crossAxisCount: 1,
      // Generate 100 widgets that display their index in the List.
      children:
      List.generate(controller.musicList.length, (index) {
        return Card(
          color: Colors.cyan.shade50,
          child: InkWell(
            splashColor: Colors.cyanAccent,
            hoverColor: Colors.lightBlue[100],
            onTap: () => controller.buyCoupon(musicPrice, index, context),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    iconSize: 30,
                    tooltip: 'Press to hear preview',
                    onPressed: () => MusicController.playDemo(controller.musicList[index].fileName),
                  ),
                  Text(
                    controller.musicList[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/TrunkCoinIcon.png',
                        width: 28.0,
                        height: 28.0,
                      ),
                      Padding(padding: EdgeInsets.all(2.5)),
                      Text(
                        musicPrice.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
