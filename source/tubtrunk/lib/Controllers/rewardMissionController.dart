import 'package:flutter/cupertino.dart';
import 'package:tubtrunk/Controllers/mainController.dart';
import 'package:tubtrunk/Models/rewardMissionModel.dart';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'dart:convert';

class RewardMissionController {
  List<RewardMissionModel> stubDB;

  List<RewardMissionModel> _availableMissions;
  List<RewardMissionModel> get availableMissions => _availableMissions;

  List<RewardMissionModel> _inProgressMissions;
  List<RewardMissionModel> get inProgressMissions => _inProgressMissions;

  List<RewardMissionModel> _achievedMissions;
  List<RewardMissionModel> get achievedMissions => _achievedMissions;

  int prizeMoney = 0;

  Function(VoidCallback) setStateCallback;

  RewardMissionController() {
    fetchAvailableMissions();
    fetchAcceptedMissions();
  }

  void fetchAvailableMissions() async {
    _availableMissions = [];

    var map = new Map<String, String>();
    map["UserID"] = "1";

    var response = await http.post(
        GlobalSettings.serverAddress + "getAvailableMissions.php",
        body: map
    );

    if (response.statusCode == 200) {
      _availableMissions = List<RewardMissionModel>.from(json
          .decode(response.body)
          .map((tr) => RewardMissionModel.fromJson(tr))
      );
    }
  }

  void fetchAcceptedMissions() async {
    _inProgressMissions = [];
    _achievedMissions = [];

    var map = new Map<String, String>();
    map["UserID"] = "1";

    var response = await http.post(
        GlobalSettings.serverAddress + "getAcceptedMissions.php",
        body: map
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var key in data) {
        RewardMissionModel mission = RewardMissionModel.fromJson(key);
        if (mission.inProgress) {
          inProgressMissions.add(mission);
        }
        else {
          achievedMissions.add(mission);
        }
      }
    }
  }

  void moveMissionToInProgress(RewardMissionModel mission) {
    setStateCallback(() {
      availableMissions.remove(mission);
      inProgressMissions.add(mission);
    });
  }

  void updateRequirementProgress(int minutes) {
    setStateCallback(() {
      List<RewardMissionModel> completedMissions = [];
      for (RewardMissionModel mission in inProgressMissions) {
        mission.addMinutes(minutes);
        if (mission.isCompleted()) {
          completedMissions.add(mission);
        }
      }

      for (RewardMissionModel mission in completedMissions) {
        inProgressMissions.remove(mission);
        ++mission.completedRequirements;
        achievedMissions.add(mission);

        MainController().addMoney(mission.prize);
      }
    });
  }
}
