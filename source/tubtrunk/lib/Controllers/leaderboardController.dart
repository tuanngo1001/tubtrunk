import 'package:tubtrunk/Utils/globalSettings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Models/userModel.dart';

class LeaderboardController {
  List<UserModel> _usersList;

  LeaderboardController(){}

  Future<List<UserModel>> fetchAllUsers() async {
    var url = GlobalSettings.serverAddress + "getAllUsers.php";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var key in data) {
        _usersList.add(UserModel.fromJson(key));
      }
      // rankAllUsersByMoney(_usersList);
      return Future.delayed(Duration(seconds: 1), () => _usersList);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }

  // void rankAllUsersByMoney(List<UserModel> list) {
  //   for (var i = 0; i < list.length; i++) {
  //     int max = i;
  //     for (var j = i + 1; j < list.length; j++) {
  //       if (list[max].prize < list[j].prize) {
  //         max = j;
  //       }
  //     }
  //     if (max != i) {
  //       UserModel tmp = list[i];
  //       list[i] = list[max];
  //       list[max] = tmp;
  //     }
  //   }
  // }
}
