import 'rewardRequirementModel.dart';

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
  List<RewardRequirementModel> requirementsList = [];
  String missionStatus;
  int completedRequirements;

  RewardMissionModel(this.missionName, this.prizeMoney, this.missionStatus,
      this.completedRequirements) {
    requirementsList = [];
  }

  void addRequirement(RewardRequirementModel requirement) {
    requirementsList.add(requirement);
  }
}
