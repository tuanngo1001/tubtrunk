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

  int id;
  String title;
  int prize;
  List<dynamic> requirements;
  bool inProgress;
  List<int> progressTrack;

  int completedRequirements;

  RewardMissionModel({this.id, this.title, this.prize, this.requirements, this.inProgress, this.progressTrack}) {
    completedRequirements = 0;
    for (int i = 0; i < progressTrack.length; i++) {
      if (requirements[i][_timesIndex] == progressTrack[i]) {
        ++completedRequirements;
      }
    }
  }

  bool addDuration(int minutes) {
    bool updated = false;
    for (int i = 0; i < requirements.length; i++) {
      if (requirements[i][_minutesIndex] == minutes && progressTrack[i] < requirements[i][_timesIndex]) {
        updated = true;
        ++progressTrack[i];

        if (progressTrack[i] == requirements[i][_timesIndex]) {
          ++completedRequirements;
        }
      }
    }

    return updated;
  }

  bool isCompleted() {
    for (int i = 0; i < requirements.length; i++) {
      if (requirements[i][_timesIndex] != progressTrack[i]) {
        return false;
      }
    }

    return true;
  }

  factory RewardMissionModel.fromJson(Map<String, dynamic> json) {
    return RewardMissionModel(
      id: json['ID'],
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
      int remainingTimes = progressTrack.length > 0 ? (times - progressTrack[i]) : times;
      if (remainingTimes == 0) {
        requirementDesc = requirementDesc + "\n-You have to focus $minutes minutes for $remainingTimes time(s). [✓]\n";
      }
      else {
        requirementDesc = requirementDesc + "\n-You have to focus $minutes minutes for $times time(s).\n";
      }
    }

    return requirementDesc;
  }
}
