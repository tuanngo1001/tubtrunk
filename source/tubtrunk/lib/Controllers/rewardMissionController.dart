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
    loadMissions();
  }

  void loadMissions() async {
    _availableMissions = [];
    _inProgressMissions = [];
    _achievedMissions = [];

    await fetchAvailableMissions();
    await fetchAcceptedMissions();

    if (setStateCallback != null) {
      setStateCallback(() {});
    }
  }

  Future fetchAvailableMissions() async {
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

  Future fetchAcceptedMissions() async {
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
          _inProgressMissions.add(mission);
        }
        else {
          _achievedMissions.add(mission);
        }
      }
    }
  }

  void moveMissionToInProgress(RewardMissionModel mission) async {
    var map = new Map<String, String>();
    map["UserID"] = "1";
    map["MissionID"] = mission.id.toString();

    await http.post(
        GlobalSettings.serverAddress + "acceptMission.php",
        body: map
    );

    loadMissions();
  }

  void updateRequirementProgress(int minutes) async {
    List<RewardMissionModel> updatedMissions = [];
    for (RewardMissionModel mission in inProgressMissions) {
      if (mission.addMinutes(minutes)) {
        updatedMissions.add(mission);
      }
    }

    for (RewardMissionModel mission in updatedMissions) {
      bool isCompleted = mission.isCompleted();
      bool successfulUpdated = await _updateMissionProgress(mission, isCompleted);

      if (isCompleted && successfulUpdated) {
        MainController().addMoney(mission.prize);
      }
    }

    loadMissions();
  }

  Future<bool> _updateMissionProgress(RewardMissionModel mission, bool isCompleted) async {
    var map = new Map<String, String>();
    map["UserID"] = "1";
    map["MissionID"] = mission.id.toString();
    map["InProgress"] = isCompleted ? "0" : "1";
    map["ProgressTrack"] = mission.progressTrack.toString();

    var response = await http.post(
        GlobalSettings.serverAddress + "updateMissionProgress.php",
        body: map
    );

    return response.statusCode == 200;
  }
}
