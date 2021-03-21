import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tubtrunk/Models/couponModel.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';

class StoreController {

  //Singleton instance
  static final StoreController theOnlyStoreController = StoreController._initializerFunction();

  //#region Properties
  List<CouponModel> couponList = <CouponModel>[];

  //#endregion

  //#region Constructor

  factory StoreController(){
    return theOnlyStoreController;
  }

  StoreController._initializerFunction(){
    getCouponList();
  }
  //#endregion

  //#region Methods
  Future<List<CouponModel>> getCouponList() async {
    couponList = await _getCoupons();
    return couponList;
  }

  Future<List<CouponModel>> _getCoupons() async {
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
