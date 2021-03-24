import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/leaderboardController.dart';
import 'package:tubtrunk/Models/leaderboardModel.dart';

void main() {
  group('leaderboardController Tests', () {
    group('leaderboardController Functions Test', () {
      test("fetchAllUsers should return a List<LeaderboardModel>", () {
        LeaderboardController testLeaderboardController = new LeaderboardController();
        Future<List<LeaderboardModel>> testUsersList = testLeaderboardController.fetchAllUsers();
        testUsersList.then((value) {
          expect((testUsersList is List<LeaderboardModel>), true);
        });
      });
    });
  });
}
