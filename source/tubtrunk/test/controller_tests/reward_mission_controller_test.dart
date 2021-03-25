import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tubtrunk/Controllers/rewardMissionController.dart';
import 'package:tubtrunk/Models/rewardMissionModel.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tubtrunk/Models/userModel.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'package:collection/collection.dart';
import 'reward_mission_controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  GlobalSettings.user = UserModel.forNow(uID: 1);

  test("List of available missions should be correct after fetching", () async {
    var controller = RewardMissionController.test();
    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();

    var jsonSuccessResponse =
        '[{"ID":1,"Title":"Mission 1","Prize":50,"Requirements":[[1, 1],[2, 1],[3, 1],[4, 1]],"InProgress":false,"ProgressTrack":[]},'
        '{"ID":2,"Title":"Mission 2","Prize":200,"Requirements":[[5, 2],[10, 1],[15, 1],[20, 2]],"InProgress":false,"ProgressTrack":[]}]';

    final client = MockClient();

    // Succeed response
    when(client.post(GlobalSettings.serverAddress + "getAvailableMissions.php", body: map))
        .thenAnswer((_) async => http.Response(jsonSuccessResponse, 200));

    List<RewardMissionModel> expectedMissions = [
      RewardMissionModel(
          id: 1,
          title: "Mission 1",
          prize: 50,
          requirements: [[1, 1], [2, 1], [3, 1], [4, 1]],
          inProgress: false,
          progressTrack: []
      ),
      RewardMissionModel(
          id: 2,
          title: "Mission 2",
          prize: 200,
          requirements: [[5, 2], [10, 1], [15, 1], [20, 2]],
          inProgress: false,
          progressTrack: []
      ),
    ];

    expect(await controller.fetchAvailableMissions(httpClient: client), true);
    expect(listEquals(controller.availableMissions, expectedMissions), true);

    // Failed response
    when(client.post(GlobalSettings.serverAddress + "getAvailableMissions.php", body: map))
        .thenAnswer((_) async => http.Response("", 400));

    expect(await controller.fetchAvailableMissions(httpClient: client), false);
  });

  test("List of in-progress and achieved missions should be correct after fetching", () async {
    var controller = RewardMissionController.test();
    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();

    var jsonSuccessResponse =
        '[{"ID":1,"Title":"Mission 1","Prize":50,"Requirements":[[1, 1],[2, 1],[3, 1],[4, 1]],"InProgress":true,"ProgressTrack":[0,0,1,0]},'
        '{"ID":2,"Title":"Mission 2","Prize":200,"Requirements":[[5, 2],[10, 1],[15, 1],[20, 2]],"InProgress":true,"ProgressTrack":[1,1,0,2]},'
        '{"ID":3,"Title":"Mission 3","Prize":150,"Requirements":[[10, 1],[12, 1],[15, 1],[17, 1]],"InProgress":false,"ProgressTrack":[1,1,1,1]}]';

    List<RewardMissionModel> expectedInProgressMissions = [];
    List<RewardMissionModel> expectedAchievedMissions = [];
    var data = jsonDecode(jsonSuccessResponse);
    for (var key in data) {
      RewardMissionModel mission = RewardMissionModel.fromJson(key);
      if (mission.inProgress) {
        expectedInProgressMissions.add(mission);
      }
      else {
        expectedAchievedMissions.add(mission);
      }
    }

    final client = MockClient();

    // Succeed response
    when(client.post(GlobalSettings.serverAddress + "getAcceptedMissions.php", body: map))
        .thenAnswer((_) async => http.Response(jsonSuccessResponse, 200));

    expect(await controller.fetchAcceptedMissions(httpClient: client), true);
    expect(listEquals(controller.inProgressMissions, expectedInProgressMissions), true);
    expect(listEquals(controller.achievedMissions, expectedAchievedMissions), true);


    // Failed response
    when(client.post(GlobalSettings.serverAddress + "getAcceptedMissions.php", body: map))
        .thenAnswer((_) async => http.Response("", 400));

    expect(await controller.fetchAcceptedMissions(httpClient: client), false);
  });

  test("Mission progress should update probably", () async {
    var controller = RewardMissionController.test();
    RewardMissionModel mission = RewardMissionModel(
      id: 1,
      title: "Hi",
      prize: 50,
      requirements: [[1,1],[2,1],[3,1],[4,1]],
      progressTrack: [1,1,1,0]
    );

    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();
    map["MissionID"] = mission.id.toString();
    map["InProgress"] = "1";
    map["ProgressTrack"] = mission.progressTrack.toString();

    final client = MockClient();

    // Succeed response
    when(client.post(GlobalSettings.serverAddress + "updateMissionProgress.php", body: map))
        .thenAnswer((_) async => http.Response("", 200));

    expect(await controller.updateMissionProgress(mission, false, httpClient: client), true);


    // Failed response
    when(client.post(GlobalSettings.serverAddress + "updateMissionProgress.php", body: map))
        .thenAnswer((_) async => http.Response("", 400));

    expect(await controller.updateMissionProgress(mission, false, httpClient: client), false);
  });
}

// Assume lengths of both list equal
bool listEquals(List<RewardMissionModel> missionList1, List<RewardMissionModel> missionList2) {
  for (int i = 0; i < missionList1.length; i++) {
    if (!missionEquals(missionList1[i], missionList2[i])) {
      return false;
    }
  }

  return true;
}

bool missionEquals(RewardMissionModel mission1, RewardMissionModel mission2) {
  if (mission1.id != mission2.id)
    return false;

  if (mission1.title != mission2.title)
    return false;

  if (mission1.prize != mission2.prize)
    return false;

  if (!DeepCollectionEquality().equals(mission1.requirements, mission2.requirements))
    return false;

  if (mission1.inProgress != mission2.inProgress)
    return false;

  if (!ListEquality().equals(mission1.progressTrack, mission2.progressTrack))
    return false;

  return true;
}