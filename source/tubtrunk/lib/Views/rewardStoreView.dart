import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/storeController.dart';
import 'package:tubtrunk/Models/couponModel.dart';
import 'package:tubtrunk/Models/petModel.dart';
import 'package:tubtrunk/Views/MyCouponIcon.dart';

import 'notificationView.dart';

class RewardStoreView extends StatefulWidget {
  @override
  _RewardStoreViewState createState() => _RewardStoreViewState();
}

class _RewardStoreViewState extends State<RewardStoreView> {
  StoreController controller = new StoreController();
  List<PetModel> petList = new List<PetModel>();
  List<CouponModel> couponList = new List<CouponModel>();

  @override
  void initState() {
    getCouponList();
    stubPetList();
    super.initState();
  }

  void stubPetList() {
    petList.add(
        new PetModel("Mocha", "regular", "fat cat with some level of retard"));
    petList.add(new PetModel("Candace", "Wild", "young and wild"));
    petList.add(new PetModel("Kiko", "Rare", "Fat but old and wise"));
    petList.add(
        new PetModel("Pink Guy", "Ultra Rare", "Cosmic level of disturbance"));
  }

  Future<List<CouponModel>> getCouponList() async {

    couponList = await controller.getCoupons();
    return couponList;
  }

  void testing() {
    print("Pressed");
  }

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
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<List<CouponModel>>(
              future: getCouponList(),
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
                    GridView.count(
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      crossAxisCount: 1,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(couponList.length, (index) {
                        return Center(
                          child: InkWell(
                              splashColor: Colors.cyanAccent,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => new NotificationView()
                                        .purchasePopUp(context));
                                // Perform some action
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(18.0)),
                                      Text(
                                        couponList[index].store + " Coupon",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        couponList[index].description,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        couponList[index].price,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ))),
                        );
                      }),
                    ),
                    GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(100, (index) {
                        return Center(
                            child: InkWell(
                          splashColor: Colors.cyanAccent,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => new NotificationView()
                                    .purchasePopUp(context));
                            // Perform some action
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: new Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(18.0)),
                                Text(
                                  "AAA",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Description",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                                Text(
                                  "\$640",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ));
                      }),
                    ),
                    GridView.count(
                      childAspectRatio: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      crossAxisCount: 1,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(petList.length, (index) {
                        return Center(
                          child: InkWell(
                              splashColor: Colors.cyanAccent,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => new NotificationView()
                                        .purchasePopUp(context));
                                // Perform some action
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(18.0)),
                                      Text(
                                        petList[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        petList[index].description,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        petList[index].price,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ))),
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
                );
              }),
        ),
        //backgroundColor: Color.fromARGB(255, 202, 240, 246),
      ),
    );
//    );;
  }
}
