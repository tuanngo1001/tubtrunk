import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tubtrunk/Controllers/leaderboardController.dart';
import 'package:tubtrunk/Models/leaderboardModel.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tubtrunk/Utils/globalSettings.dart';
import 'leaderboard_controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test("List of users should be correct after fetching", () async {
    final controller = LeaderboardController();

    var jsonSuccessResponse =
        '[{"ID":1,"UserName":"Anh Trung","Prize":0,"AverageMinutes":100.0,"TotalMinutes":20,"TotalTimes":2,"TotalPrize": 0},'
        '{"ID":2,"UserName":"Anh Quoc","Prize":0,"AverageMinutes":200.0,"TotalMinutes":30,"TotalTimes":1,"TotalPrize": 0}]';

    final client = MockClient();

    // Succeed response
    when(client.get(GlobalSettings.serverAddress + "getAllUsers.php"))
        .thenAnswer((_) async => http.Response(jsonSuccessResponse, 200));

    List<LeaderboardModel> expectedUsers = [
      LeaderboardModel(
          uID: 1,
          name: "Anh Trung",
          prize: 0,
          avgFocusTime: 100.0,
          totalFocusTime: 20,
          totalTimes: 2,
          totalPrize: 0),
      LeaderboardModel(
          uID: 2,
          name: "Anh Quoc",
          prize: 0,
          avgFocusTime: 200.0,
          totalFocusTime: 30,
          totalTimes: 1,
          totalPrize: 0),
    ];
    List<LeaderboardModel> testList = await controller.fetchAllUsers(httpClient: client);

    expect(listEquals(controller.usersList, testList), true);
    expect(listEquals(controller.usersList, expectedUsers), true);

    //fail response
    when(client.get(GlobalSettings.serverAddress + "getAllUsers.php"))
        .thenAnswer((_) async => http.Response("", 400));
    List<LeaderboardModel> anotherTestList = await controller.fetchAllUsers(httpClient: client);
    expect(anotherTestList.length, 0);
  });
}

bool userEquals(LeaderboardModel user1, LeaderboardModel user2) {
  if (user1.uID != user2.uID) return false;

  if (user1.name != user2.name) return false;

  if (user1.prize != user2.prize) return false;

  if (user1.avgFocusTime != user2.avgFocusTime) return false;

  if (user1.totalFocusTime != user2.totalFocusTime) return false;

  if (user1.totalTimes != user2.totalTimes) return false;

  if (user1.totalPrize != user2.totalPrize) return false;

  return true;
}

bool listEquals(
    List<LeaderboardModel> usersList1, List<LeaderboardModel> usersList2) {
  for (int i = 0; i < usersList1.length; i++) {
    if (!userEquals(usersList1[i], usersList2[i])) {
      return false;
    }
  }
  return true;
}
