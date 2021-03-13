import 'package:tubtrunk/Models/rewardMissionModel.dart';
import 'package:tubtrunk/Models/rewardRequirementModel.dart';
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

    stubDB = [];

    stubDB.add(new RewardMissionModel("Warm-up session", 150, "lock", 0));
    stubDB.add(new RewardMissionModel("Dream big!", 300, "lock", 0));
    stubDB.add(new RewardMissionModel("You can do it!", 450, "lock", 0));
    stubDB.add(new RewardMissionModel("Dare to challenge?", 600, "lock", 0));
    stubDB.add(new RewardMissionModel("Make your life a mission", 750, "lock", 0));
    stubDB.add(new RewardMissionModel("Failure builds character!", 900, "lock", 0));

    stubDB[0].addRequirement(new RewardRequirementModel(5, 1, 1));
    stubDB[0].addRequirement(new RewardRequirementModel(10, 1, 1));
    stubDB[0].addRequirement(new RewardRequirementModel(15, 2, 1));
    stubDB[0].addRequirement(new RewardRequirementModel(20, 2, 1));

    stubDB[1].addRequirement(new RewardRequirementModel(25, 1, 1));
    stubDB[1].addRequirement(new RewardRequirementModel(30, 2, 2));
    stubDB[1].addRequirement(new RewardRequirementModel(35, 1, 1));
    stubDB[1].addRequirement(new RewardRequirementModel(40, 2, 2));

    stubDB[2].addRequirement(new RewardRequirementModel(45, 1, 1));
    stubDB[2].addRequirement(new RewardRequirementModel(50, 1, 1));
    stubDB[2].addRequirement(new RewardRequirementModel(55, 1, 1));
    stubDB[2].addRequirement(new RewardRequirementModel(60, 1, 1));

    stubDB[3].addRequirement(new RewardRequirementModel(65, 1, 1));
    stubDB[3].addRequirement(new RewardRequirementModel(70, 2, 2));
    stubDB[3].addRequirement(new RewardRequirementModel(75, 3, 3));
    stubDB[3].addRequirement(new RewardRequirementModel(80, 2, 2));

    stubDB[4].addRequirement(new RewardRequirementModel(85, 1, 1));
    stubDB[4].addRequirement(new RewardRequirementModel(90, 2, 2));
    stubDB[4].addRequirement(new RewardRequirementModel(95, 2, 2));
    stubDB[4].addRequirement(new RewardRequirementModel(100, 3, 3));

    stubDB[5].addRequirement(new RewardRequirementModel(90, 2, 2));
    stubDB[5].addRequirement(new RewardRequirementModel(100, 2, 2));
    stubDB[5].addRequirement(new RewardRequirementModel(115, 2, 2));
    stubDB[5].addRequirement(new RewardRequirementModel(120, 2, 2));
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

  List<RewardMissionModel> getInProgressRewardMissions() {
    //Querry by missionStatus attribute ("lock" for available missions, "in-progress" for In-progress missions, "achieved" for achieved missions)
    List<RewardMissionModel> inProgressMissions = [];
    for (int i = 0; i < stubDB.length; i++) {
      if (stubDB[i].missionStatus == "in-progress") {
        inProgressMissions.add(stubDB[i]);
      }
    }
    return inProgressMissions;
  }

  List<RewardMissionModel> getAchievedRewardMissions() {
    //Querry by missionStatus attribute ("lock" for available missions, "in-progress" for In-progress missions, "achieved" for achieved missions)
    List<RewardMissionModel> achievedMissions = [];
    for (int i = 0; i < stubDB.length; i++) {
      if (stubDB[i].missionStatus == "achieved") {
        achievedMissions.add(stubDB[i]);
      }
    }
    return achievedMissions;
  }

  List<RewardRequirementModel> getRewardMissionRequirements(String missionName) {
    //Querry by Mission name attribute (Foreign key) in reward requirement table
    List<RewardRequirementModel> missionRequirements = [];
    for (int i = 0; i < stubDB.length; i++) {
      if (stubDB[i].title == missionName) {
        missionRequirements = stubDB[i].requirementsList;
      }
    }
    return missionRequirements;
  }

  void moveChallengeToInProgress(String missionName) {
    // update the status of the mission from "lock" to "in-progress"
    for (int i = 0; i < stubDB.length; i++) {
      if (stubDB[i].title == missionName) {
        stubDB[i].missionStatus = "in-progress";
      }
    }
//      String missionStatus = mission.missionStatus = "in-progress";
  }

  void moveInProgressToAchieved(String missionName) {
    // update the status of the mission from "in-progress" to "lock"
    for (int i = 0; i < stubDB.length; i++) {
      if (stubDB[i].title == missionName) {
        stubDB[i].missionStatus = "achieved";
      }
    }
//      String missionStatus = mission.missionStatus="achieved";
  }

  bool isMissionCompleted(String missionName) {
    bool isCompleted = false;
    int completedRequirements = 0;
    for (int i = 0; i < stubDB.length; i++) {
      if (stubDB[i].title == missionName) {
        for (int j = 0; j < stubDB[i].requirementsList.length; i++) {
          if (stubDB[i].requirementsList[j].howManyTimesLeft == 0) {
            completedRequirements++;
            if (completedRequirements == stubDB[i].requirementsList.length) {
              isCompleted = true;
            }
          }
        }
      }
    }
    return isCompleted;
  }

  // Supposed we have the data each time the user use timer ( duration, times =1) and each requirement is unique
  // Search for duration first to see if it matches one of the requirement, if it matches, the requirement's times - 1, if requirement's times = 0 => the requirement is completed

  void updateRequirementProgress(int minutes) {
    // has to be called each time the user finish the countdown
    for (int i = 0; i < stubDB.length; i++) {
      for (int j = 0; j < stubDB[i].requirementsList.length; j++) {
        if (stubDB[i].requirementsList[j].minutes == minutes &&
            stubDB[i].requirementsList[j].howManyTimesLeft != 0) {
          stubDB[i].requirementsList[j].howManyTimesLeft--;
        } else {
          prizeMoney += minutes;
        }
      }
    }
  }

  void addMoneyFromMissions() {
    for (int i = 0; i < stubDB.length; i++) {
      if (stubDB[i].missionStatus == "achieved") {
        prizeMoney += stubDB[i].prize;
      }
    }
  }
}
