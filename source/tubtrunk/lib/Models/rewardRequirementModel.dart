/*
Attributes for Reward requirement table
      int minutes  unique
      int times
      int howManyTimesLeft
      foreign key (mission name)

 */

class RewardRequirementModel {
  int minutes;
  int times;
  int howManyTimesLeft;

  RewardRequirementModel(this.minutes, this.times, this.howManyTimesLeft);

  @override
  String toString() {
    String requirement;
    if (howManyTimesLeft != 0) {
      requirement =
          "\n-You have to focus $minutes minutes for $times time(s).\n";
    } else {
      requirement =
          "\n-You have to focus $minutes minutes for $times time(s).[✓]\n";
    }

    return requirement;
  }
}
