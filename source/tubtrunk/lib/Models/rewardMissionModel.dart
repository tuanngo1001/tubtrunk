import 'rewardRequirementModel.dart';

/*
Attributes for Reward Mission table
      Mission name - 48 chars  unique
      Prize money - <1000 int
      Mission status - 20 chars                      (lock or in-progress or achieved)
      int completedRequirements


 */

class RewardMission {
  String _missionName;
  int _prizeMoney;
  bool _isFinished = false;
  List<RewardRequirement> requirementsList = List<RewardRequirement>();
  String _missionStatus;
  int _completedRequirements;

  RewardMission(this._missionName, this._prizeMoney, this._missionStatus,
      this._completedRequirements) {
    requirementsList = List<RewardRequirement>();
  }
//    _completedRequirements=0;
//    requirementsList = List<RewardRequirement>();
//    requirementsList.add(new RewardRequirement(10,2));
//    requirementsList.add(new RewardRequirement(60,1));
//    requirementsList.add(new RewardRequirement(30,1));
//    requirementsList.add(new RewardRequirement(45,16));
////    missionType="lock";           // lock, in-progress, achieved

  void addRequiremnt(RewardRequirement requirement) {
    requirementsList.add(requirement);
  }

  String get missionStatus => _missionStatus;

  set missionStatus(String value) {
    _missionStatus = value;
  }

  String get missionName => _missionName;

  set missionName(String value) {
    _missionName = value;
  }
//
//  bool get isFinished => _isFinished;
//
//  set isFinished(bool value) {
//    _isFinished = value;
//  }
//

  int get prizeMoney => _prizeMoney;

  set prizeMoney(int value) {
    _prizeMoney = value;
  }

  int get completedRequirements => _completedRequirements;

  set completedRequirements(int value) {
    _completedRequirements = value;
  }
}
