import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/leaderboardController.dart';
import 'package:tubtrunk/Models/userModel.dart';

void main() {
  group('leaderboardController Tests', () {
    group('leaderboardController Functions Test', () {
      test("fetchAllUsers should return a List<UserModel>", () {
        LeaderboardController testLeaderboardController = new LeaderboardController();
        Future<List<UserModel>> testUsersList = testLeaderboardController.fetchAllUsers();
        testUsersList.then((value) {
          expect((testUsersList is List<UserModel>), true);
        });
      });
    });
  });
}
