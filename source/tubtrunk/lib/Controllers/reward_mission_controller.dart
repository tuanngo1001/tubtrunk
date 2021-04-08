import 'package:flutter/cupertino.dart';
import 'package:tubtrunk/Controllers/main_controller.dart';
import 'package:tubtrunk/Models/reward_mission_model.dart';
import 'package:http/http.dart' as http;
import 'package:tubtrunk/Utils/global_settings.dart';
import 'dart:convert';

class RewardMissionController {
  List<RewardMissionModel> _availableMissions;
  List<RewardMissionModel> get availableMissions => _availableMissions;

  List<RewardMissionModel> _inProgressMissions;
  List<RewardMissionModel> get inProgressMissions => _inProgressMissions;

  List<RewardMissionModel> _achievedMissions;
  List<RewardMissionModel> get achievedMissions => _achievedMissions;

  Function(VoidCallback) setStateCallback;

  RewardMissionController.test() {
    initializeMissionList();
  }

  RewardMissionController() {
    loadMissions();
  }

  void initializeMissionList() {
    _availableMissions = [];
    _inProgressMissions = [];
    _achievedMissions = [];
  }

  void loadMissions() async {
    initializeMissionList();

    await fetchAvailableMissions();
    await fetchAcceptedMissions();

    if (setStateCallback != null) {
      setStateCallback(() {});
    }
  }

  Future<bool> fetchAvailableMissions({http.Client httpClient}) async {
    if (httpClient == null) {
      httpClient = http.Client();
    }

    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();

    var response = await httpClient.post(
        GlobalSettings.serverAddress + "getAvailableMissions.php",
        body: map
    );

    if (response.statusCode == 200) {
      _availableMissions = List<RewardMissionModel>.from(json
          .decode(response.body)
          .map((tr) => RewardMissionModel.fromJson(tr))
      );
      return true;
    }

    return false;
  }

  Future<bool> fetchAcceptedMissions({http.Client httpClient}) async {
    if (httpClient == null) {
      httpClient = http.Client();
    }

    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();

    var response = await httpClient.post(
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
      return true;
    }

    return false;
  }

  Future<bool> moveMissionToInProgress(RewardMissionModel mission, {http.Client httpClient}) async {
    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();
    map["MissionID"] = mission.id.toString();

    if (httpClient == null)
      httpClient = http.Client();

    var response = await httpClient.post(
        GlobalSettings.serverAddress + "acceptMission.php",
        body: map
    );

    return response.statusCode == 200;
  }

  void updateRequirementProgress(int minutes) async {
    List<RewardMissionModel> updatedMissions = [];
    for (RewardMissionModel mission in inProgressMissions) {
      if (mission.addDuration(minutes)) {
        updatedMissions.add(mission);
      }
    }

    for (RewardMissionModel mission in updatedMissions) {
      bool isCompleted = mission.isCompleted();
      bool successfulUpdated = await updateMissionProgress(mission, isCompleted);

      if (isCompleted && successfulUpdated) {
        MainController().addMoney(mission.prize);
      }
    }

    loadMissions();
  }

  Future<bool> updateMissionProgress(RewardMissionModel mission, bool isCompleted, {http.Client httpClient}) async {
    if (httpClient == null) {
      httpClient = http.Client();
    }

    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();
    map["MissionID"] = mission.id.toString();
    map["InProgress"] = isCompleted ? "0" : "1";
    map["ProgressTrack"] = mission.progressTrack.toString();

    var response = await httpClient.post(
        GlobalSettings.serverAddress + "updateMissionProgress.php",
        body: map
    );

    return response.statusCode == 200;
  }
}
