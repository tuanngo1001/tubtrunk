import 'rewardRequirementModel.dart';

/*
Attributes for Reward Mission table
      Mission name - 48 chars  unique
      Prize money - <1000 int
      Mission status - 20 chars                      (lock or in-progress or achieved)
      int completedRequirements


 */

class RewardMissionModel {
  static int _minutesIndex = 0;
  static int _timesIndex = 1;

  String title;
  int prize;
  List<dynamic> requirements;
  List<RewardRequirementModel> requirementsList = [];
  String missionStatus;
  int completedRequirements;

  RewardMissionModel(this.title, this.prize, this.missionStatus, this.completedRequirements) {
    requirementsList = [];
  }

  RewardMissionModel._internal({this.title, this.prize, this.requirements}) {}

  void addRequirement(RewardRequirementModel requirement) {
    requirementsList.add(requirement);
  }

  factory RewardMissionModel.fromJson(Map<String, dynamic> json) {
    return RewardMissionModel._internal(
        title: json['Title'],
        prize: json['Prize'],
        requirements: json['Requirements']
    );
  }

  @override
  String toString() {
    String requirementDesc = "";
    for (List<dynamic> requirement in requirements) {
      int minutes = requirement[_minutesIndex];
      int times = requirement[_timesIndex];
      requirementDesc = requirementDesc + "\n-You have to focus $minutes minutes for $times time(s).\n";
    }

    return requirementDesc;
  }
}
