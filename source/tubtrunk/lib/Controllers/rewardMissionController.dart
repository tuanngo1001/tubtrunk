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

  void moveChallengeToInProgress(String missionName) {
    // update the status of the mission from "lock" to "in-progress"
    // for (int i = 0; i < stubDB.length; i++) {
    //   if (stubDB[i].title == missionName) {
    //     stubDB[i].missionStatus = "in-progress";
    //   }
    // }
//      String missionStatus = mission.missionStatus = "in-progress";
  }

  void moveInProgressToAchieved(String missionName) {
    // update the status of the mission from "in-progress" to "lock"
    // for (int i = 0; i < stubDB.length; i++) {
    //   if (stubDB[i].title == missionName) {
    //     stubDB[i].missionStatus = "achieved";
    //   }
    // }
//      String missionStatus = mission.missionStatus="achieved";
  }

  // Supposed we have the data each time the user use timer ( duration, times =1) and each requirement is unique
  // Search for duration first to see if it matches one of the requirement, if it matches, the requirement's times - 1, if requirement's times = 0 => the requirement is completed

  // void updateRequirementProgress(int minutes) {
  //   // has to be called each time the user finish the countdown
  //   for (int i = 0; i < stubDB.length; i++) {
  //     for (int j = 0; j < stubDB[i].requirementsList.length; j++) {
  //       if (stubDB[i].requirementsList[j].minutes == minutes &&
  //           stubDB[i].requirementsList[j].howManyTimesLeft != 0) {
  //         stubDB[i].requirementsList[j].howManyTimesLeft--;
  //       } else {
  //         prizeMoney += minutes;
  //       }
  //     }
  //   }
  // }
  //
  // void addMoneyFromMissions() {
  //   for (int i = 0; i < stubDB.length; i++) {
  //     if (stubDB[i].missionStatus == "achieved") {
  //       prizeMoney += stubDB[i].prize;
  //     }
  //   }
  // }
}
