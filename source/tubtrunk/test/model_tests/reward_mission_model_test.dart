import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Models/reward_mission_model.dart';

void main() {
  test("Properties of created mission should match with given inputs", () {
    RewardMissionModel parsedMission = RewardMissionModel(
      id: 1,
      title: "Test",
      prize: 100,
      requirements: [[1, 1], [2, 1], [3, 1], [4, 1]],
      inProgress: true,
      progressTrack: [0, 1, 1, 1]
    );

    expect(parsedMission.id, 1);
    expect(parsedMission.title, "Test");
    expect(parsedMission.prize, 100);
    expect(parsedMission.requirements, [[1, 1], [2, 1], [3, 1], [4, 1]]);
    expect(parsedMission.inProgress, true);
    expect(parsedMission.progressTrack, [0, 1, 1, 1]);
    expect(parsedMission.completedRequirements, 3);
  });

  test("Reward mission should not accept mismatched duration", () {
    RewardMissionModel mission = RewardMissionModel(
      requirements: [[1, 1], [2, 1], [3, 1], [4, 1]],
      inProgress: true,
      progressTrack: [0, 1, 1, 1]
    );

    expect(mission.progressTrack, [0, 1, 1, 1]);
    expect(mission.completedRequirements, 3);

    mission.addDuration(5);

    // Progress must not change
    expect(mission.progressTrack, [0, 1, 1, 1]);
    expect(mission.completedRequirements, 3);
  });

  test("Mission should update its progress for the duration matches any of requirements", () {
    RewardMissionModel mission = RewardMissionModel(
        requirements: [[1, 1], [2, 1], [3, 1], [4, 1]],
        inProgress: true,
        progressTrack: [0, 0, 1, 1]
    );

    expect(mission.progressTrack, [0, 0, 1, 1]);
    expect(mission.completedRequirements, 2);

    mission.addDuration(2);

    // Progress should update
    expect(mission.progressTrack, [0, 1, 1, 1]);
    expect(mission.completedRequirements, 3);
  });

  test("Progress of a requirement of a mission should update if the given duration matches", () {
    RewardMissionModel mission = RewardMissionModel(
        requirements: [[1, 1], [2, 2], [3, 1], [4, 1]],
        inProgress: true,
        progressTrack: [0, 0, 1, 1]
    );

    expect(mission.progressTrack, [0, 0, 1, 1]);
    expect(mission.completedRequirements, 2);

    mission.addDuration(2);

    expect(mission.progressTrack, [0, 1, 1, 1]);
    expect(mission.completedRequirements, 2);
  });

  test("Completed requirements should increase if the progress count of a requirement equals its required times", () {
    RewardMissionModel mission = RewardMissionModel(
        requirements: [[1, 1], [2, 1], [3, 1], [4, 1]],
        inProgress: true,
        progressTrack: [0, 0, 1, 1]
    );

    expect(mission.progressTrack, [0, 0, 1, 1]);
    expect(mission.completedRequirements, 2);

    mission.addDuration(2);

    expect(mission.progressTrack, [0, 1, 1, 1]);
    expect(mission.completedRequirements, 3);
  });

  test("Mission should be completed when all requirements are done", () {
    RewardMissionModel mission = RewardMissionModel(
        requirements: [[1, 1], [2, 1], [3, 1], [4, 1]],
        inProgress: true,
        progressTrack: [0, 1, 1, 1]
    );

    mission.addDuration(1);

    expect(mission.progressTrack, [1, 1, 1, 1]);
    expect(mission.completedRequirements, 4);
    expect(mission.isCompleted(), true);
  });

  test("Parse json to a mission should show correct properties", () {
    Map<String, dynamic> missionJSON = {
      "ID" : 1,
      "Title" : "Medium mission",
      "Prize": 50,
      "Requirements" : [[1, 1], [2, 1], [3, 1], [4, 1]],
      "InProgress" : true,
      "ProgressTrack": [0, 1, 0, 0]
    };

    RewardMissionModel parsedMission = RewardMissionModel.fromJson(missionJSON);
    expect(parsedMission.id, 1);
    expect(parsedMission.title, "Medium mission");
    expect(parsedMission.prize, 50);
    expect(parsedMission.requirements, [[1, 1], [2, 1], [3, 1], [4, 1]]);
    expect(parsedMission.inProgress, true);
    expect(parsedMission.progressTrack, [0, 1, 0, 0]);
  });
}