import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tubtrunk/Models/couponModel.dart';
import 'package:tubtrunk/Models/petModel.dart';
import 'package:tubtrunk/Models/userModel.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';

class StoreController {

  //Singleton instance
  static final StoreController theOnlyStoreController = StoreController._initializerFunction();

  //#region Properties
  List<PetModel> petList = new List<PetModel>();
  List<CouponModel> couponList = new List<CouponModel>();


  //#endregion

  //#region Constructor

  factory StoreController(){
    return theOnlyStoreController;
  }

  StoreController._initializerFunction(){
    stubPetList();
    getCouponList();
    print("GET INITED ");
  }
  //#endregion

  //#region Methods
  void stubPetList() {
    petList.add(new PetModel("Mocha", "regular", "fat cat with some level of retard"));
    petList.add(new PetModel("Candace", "Wild", "young and wild"));
    petList.add(new PetModel("Kiko", "Rare", "Fat but old and wise"));
    petList.add(new PetModel("Pink Guy", "Ultra Rare", "Cosmic level of disturbance"));
  }

  Future<List<CouponModel>> getCouponList() async {
    couponList = await getCoupons();
    return couponList;
  }

  Future<List<CouponModel>> getCoupons() async {
    List<CouponModel> couponList = [];

    var url = GlobalSettings.serverAddress + "getCoupons.php";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var key in data) {
        couponList.add(CouponModel.fromJson(key));
      }
      //return couponList;
      return Future.delayed(Duration(seconds: 1), () => couponList);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> userList = [];

    var url = 'https://tubtrunk.tk/getUsers.php';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var key in data) {
        userList.add(UserModel.fromJson(key));
      }
      return userList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }

  void removePetAtIndex(int index){
    petList.removeAt(index);
  }

  Future<void> removeCouponAtIndex(int index) async{
    var map = new Map<String, String>();
    map["couponID"] = couponList[index].id.toString();

    var response = await http.post(GlobalSettings.serverAddress + "removeCouponByID.php", body: map);

    if (response.statusCode == 200) {
      print("Successfully delete coupon item");
      getCouponList();

    }

    print("Coupon deleted");
  }

//#endregion

}
