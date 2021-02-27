import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tubtrunk/Models/Coupon.dart';
import 'package:tubtrunk/Models/User.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';

class storeController{

  storeController();

  //#region Methods
  Future<List<Coupon>> getCoupons() async{
    List<Coupon> couponList = [];

    var url = GlobalSettings.ServerAddress + "getCoupons.php";
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);

      for(var key in data){
        couponList.add(Coupon.fromJson(key));
      }
      //return couponList;
      return Future.delayed(
          Duration(seconds: 1),() => couponList);
    }else{
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }

  Future<List<User>> getUsers() async{
    List<User> userList = [];

    var url = 'https://tubtrunk.tk/getUsers.php';
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);

      for(var key in data){
        userList.add(User.fromJson(key));
      }
      return userList;
    }else{
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }




//#endregion

}