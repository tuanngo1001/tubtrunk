import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Controllers/mainController.dart';
import 'dart:convert';
import 'package:tubtrunk/Models/couponModel.dart';
import 'package:tubtrunk/Models/music_model.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'package:tubtrunk/Views/notificationView.dart';

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

  void buyCoupon(int itemPrice, int itemIndex, BuildContext context) {
    if (!_checkMoney(itemPrice, context))
      return;

    _showVerification(
      itemPrice,
      itemIndex,
      () => _processBoughtCoupon(itemPrice),
      context,
    );
  }

  void buyMusic(int itemPrice, int itemIndex, BuildContext context) {
    if (!_checkMoney(itemPrice, context))
      return;

    _showVerification(
      itemPrice,
      itemIndex,
      () => _processBoughtMusic(itemPrice),
      context,
    );
  }

  bool _checkMoney(int itemPrice, BuildContext context) {
    if (itemPrice > GlobalSettings.user.money) {
      showDialog(
          context: context,
          builder: (_) => new NotificationView().notEnoughMoney(context)
      );

      return false;
    }

    return true;
  }

  void _showVerification(int itemPrice, int itemIndex, Function processBoughtItem, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => new NotificationView().purchasePopUp(
        context,
        processBoughtItem,
      ),
    );
  }

  void _processBoughtCoupon(int itemPrice) {
    MainController().addMoney(-itemPrice);
  }

  void _processBoughtMusic(int itemPrice) {
    MainController().addMoney(-itemPrice);

  }
//#endregion

}
