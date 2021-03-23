import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Controllers/leaderboardController.dart';
import 'package:tubtrunk/Models/userModel.dart';

void main() {
  group('leaderboardController Tests', () {
    group('Initialization Test', () {
      test("The leaderboardController instance should be not null", () {
        LeaderboardController testLeaderboardController = new LeaderboardController();
        expect(testLeaderboardController, isNotNull);
      });

      test("usersList variable shouldn't be null", () {
        LeaderboardController testLeaderboardController = new LeaderboardController();
        expect(testLeaderboardController.usersList, isNotNull);
      });
    });

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
