import 'package:tubtrunk/Utils/global_settings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Models/leaderboardModel.dart';

class LeaderboardController {
  List<LeaderboardModel> _usersList;
  LeaderboardController(){
    _usersList= [];
  }

  Future<List<LeaderboardModel>> fetchAllUsers({http.Client httpClient}) async {
    if (httpClient == null) {
      httpClient = http.Client();
    }
    var url = GlobalSettings.serverAddress + "getAllUsers.php";
    var response = await httpClient.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var key in data) {
        _usersList.add(LeaderboardModel.fromJson(key));
      }
      return _usersList;
    } else {
      _usersList=[];
      return _usersList;
    }
  }

  List<LeaderboardModel> get usersList => _usersList;
}
