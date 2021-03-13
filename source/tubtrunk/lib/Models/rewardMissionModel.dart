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
  bool inProgress;
  List<int> progressTrack;

  int completedRequirements;

  RewardMissionModel._internal({this.title, this.prize, this.requirements, this.inProgress, this.progressTrack}) {
    completedRequirements = 0;
    for (int i = 0; i < progressTrack.length; i++) {
      if (requirements[i][_timesIndex] == progressTrack[i]) {
        ++completedRequirements;
      }
    }
  }

  factory RewardMissionModel.fromJson(Map<String, dynamic> json) {
    return RewardMissionModel._internal(
      title: json['Title'],
      prize: json['Prize'],
      requirements: json['Requirements'],
      inProgress: json['InProgress'],
      progressTrack: json['ProgressTrack'].cast<int>()
    );
  }

  @override
  String toString() {
    String requirementDesc = "";
    for (int i = 0; i < requirements.length; i++) {
      int minutes = requirements[i][_minutesIndex];
      int times = requirements[i][_timesIndex];
      if (progressTrack.length > 0 && times == progressTrack[i]) {
        requirementDesc = requirementDesc + "\n-You have to focus $minutes minutes for $times time(s). [✓]\n";
      }
      else {
        requirementDesc = requirementDesc + "\n-You have to focus $minutes minutes for $times time(s).\n";
      }
    }

    return requirementDesc;
  }
}
