import 'RewardRequirementModel.dart';

/*
Attributes for Reward Mission table
      Mission name - 48 chars  unique
      Prize money - <1000 int
      Mission status - 20 chars                      (lock or in-progress or achieved)
      int completedRequirements


 */

class RewardMissionModel {
  String missionName;
  int prizeMoney;
  // bool isFinished = false;
  List<RewardRequirementModel> requirementsList =
      List<RewardRequirementModel>();
  String missionStatus;
  int completedRequirements;

  RewardMissionModel(this.missionName, this.prizeMoney, this.missionStatus,
      this.completedRequirements) {
    requirementsList = List<RewardRequirementModel>();
  }

  void addRequiremnt(RewardRequirementModel requirement) {
    requirementsList.add(requirement);
  }
}
