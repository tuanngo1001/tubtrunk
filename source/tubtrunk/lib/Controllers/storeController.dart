import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tubtrunk/Models/couponModel.dart';
import 'package:tubtrunk/Models/music_model.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';

class StoreController {
  //Singleton instance
  static final StoreController theOnlyStoreController = StoreController._instantiate();

  //#region Properties
  List<CouponModel> _couponList = [];
  List<CouponModel> get couponList => _couponList;

  List<MusicModel> _musicList = [];
  List<MusicModel> get musicList => _musicList;

  //#endregion

  //#region Constructor

  factory StoreController(){
    return theOnlyStoreController;
  }

  StoreController._instantiate() {
    _loadMusics();
  }
  //#endregion

  //#region Methods
  Future<List<CouponModel>> loadCouponList() async {
    _couponList = [];

    var url = GlobalSettings.serverAddress + "getCoupons.php";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var key in data) {
        _couponList.add(CouponModel.fromJson(key));
      }

      await Future.delayed(Duration(seconds: 1));
    }

    return _couponList;
  }

  Future<void> removeCouponAtIndex(int index) async {
    var map = new Map<String, String>();
    map["couponID"] = couponList[index].id.toString();

    var response = await http.post(GlobalSettings.serverAddress + "removeCouponByID.php", body: map);

    if (response.statusCode == 200) {
      print("Successfully delete coupon item");
      loadCouponList();
    }
    print("Coupon deleted");
  }

  Future<void> _loadMusics() async {
    _musicList = [];

    var url = GlobalSettings.serverAddress + "getMusics.php";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var key in data) {
        _musicList.add(MusicModel.fromJson(key));
      }

      await Future.delayed(Duration(seconds: 1));
    }

    return _musicList;
  }
//#endregion

}
