import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/storeController.dart';
import 'package:tubtrunk/Models/Coupon.dart';
import 'package:tubtrunk/Models/Pet.dart';
import 'package:tubtrunk/Views/myCouponIcon.dart';

class RewardStorePage extends StatefulWidget {
  @override
  _RewardStorePageState createState() => _RewardStorePageState();
}

class _RewardStorePageState extends State<RewardStorePage>{

  @override
  void initState(){
    Stub_Pet_List();
    getCouponList();
    super.initState();
  }

  storeController controller = new storeController();

  List<Pet> pet_list = new List<Pet>();
  List<Coupon> coupon_list = new List<Coupon>();

  void Stub_Pet_List(){
    pet_list.add(new Pet("Mocha", "regular", "fat cat with some level of retard"));
    pet_list.add(new Pet("Candace", "Wild", "young and wild"));
    pet_list.add(new Pet("Kiko", "Rare", "Fat but old and wise"));
    pet_list.add(new Pet("Pink Guy", "Ultra Rare", "Cosmetic level of disturbance"));
  }

  void getCouponList() async{
     coupon_list = await controller.getCoupons();
     print(coupon_list.length);
  }

  void Testing(){
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
          child: TabBarView(
            children: [
              GridView.count(
                childAspectRatio: 3.2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                crossAxisCount: 1,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(coupon_list.length, (index){
                  return Center(
                    child: InkWell(
                      onTap: Testing,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.all(18.0)),
                                  Text(
                                    coupon_list[index].store + " Coupon",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  Text(
                                    coupon_list[index].description,
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                  ),
                                ],
                              )
                      )
                    ),
                  );
                }),
              ),
              GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 4,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(100, (index) {
                  return Center(
                    child: InkWell(
                      onTap: Testing,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(18.0)),
                            Text(
                              "AAA",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "Description",
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    )
                  );
                }),
              ),
              GridView.count(
                childAspectRatio: 4,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                crossAxisCount: 1,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(pet_list.length, (index) {
                  return Center(
                    child: InkWell(
                        onTap: Testing,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(18.0)),
                                Text(
                                  pet_list[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                Text(
                                  pet_list[index].description,
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                ),
                              ],
                            )
                        )
                    ),
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
        //backgroundColor: Color.fromARGB(255, 202, 240, 246),
      ),
    );
//    );;
  }
}