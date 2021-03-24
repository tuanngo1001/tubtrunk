import 'package:tubtrunk/Utils/globalSettings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Models/leaderboardModel.dart';

class LeaderboardController {
  List<LeaderboardModel> _usersList;
  LeaderboardController(){
    _usersList= [];
  }

  Future<List<LeaderboardModel>> fetchAllUsers() async {
    var url = GlobalSettings.serverAddress + "getAllUsers.php";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var key in data) {
        _usersList.add(LeaderboardModel.fromJson(key));
      }
      return _usersList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }

  List<LeaderboardModel> get usersList => _usersList;
}
