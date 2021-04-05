// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'reward_system_test.dart' as RewardSystemTest;
import 'leaderboard_test.dart' as LeaderboardTest;
import 'statistic_test.dart' as StatisticsTest;
void main() {
  RewardSystemTest.user_story_1();
  StatisticsTest.main();
  LeaderboardTest.main();

}