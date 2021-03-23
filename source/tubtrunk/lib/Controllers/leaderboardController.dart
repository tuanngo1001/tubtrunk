import 'package:tubtrunk/Utils/globalSettings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Models/userModel.dart';

class LeaderboardController {
  List<UserModel> _usersList;
  LeaderboardController(){
    _usersList= [];
  }

  Future<List<UserModel>> fetchAllUsers() async {
    var url = GlobalSettings.serverAddress + "getAllUsers.php";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var key in data) {
        _usersList.add(UserModel.fromJson(key));
      }
      return _usersList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }
}
