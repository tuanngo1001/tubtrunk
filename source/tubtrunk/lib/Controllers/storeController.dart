import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tubtrunk/Models/CouponModel.dart';
import 'package:tubtrunk/Models/UserModel.dart';

class StoreController {
  StoreController();

  //#region Methods
  Future<List<CouponModel>> getCoupons() async {
    List<CouponModel> couponList = new List<CouponModel>();

    var url = 'https://tubtrunk.tk/getCoupons.php';
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
    List<UserModel> userList = new List<UserModel>();

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

//#endregion

}
