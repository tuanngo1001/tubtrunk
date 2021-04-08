// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'reward_system_test.dart' as RewardSystemTest;
import 'leaderboard_test.dart' as LeaderboardTest;
import 'statistic_test.dart' as StatisticsTest;
import 'timer_test.dart' as TimerTest;
import 'networking_test.dart' as NetworkingTest;

void main() {
  NetworkingTest.runTests();
  RewardSystemTest.runTests();
  StatisticsTest.runTests();
  TimerTest.runTests();
  LeaderboardTest.runTests();
}
