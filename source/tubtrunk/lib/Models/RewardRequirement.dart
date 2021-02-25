
/*
Attributes for Reward requirement table
      int minutes  unique
      int times
      int howManyTimesLeft
      foreign key (mission name)

 */


class RewardRequirement{

  int _minutes;
  int _times;
  int _howManyTimesLeft;

  RewardRequirement(this._minutes, this._times, this._howManyTimesLeft);

  int get minutes => _minutes;

  set minutes(int value) {
    _minutes = value;
  }

  int get times => _times;

  set times(int value) {
    _times = value;
  }

  int get howManyTimesLeft => _howManyTimesLeft;

  set howManyTimesLeft(int value) {
    _howManyTimesLeft = value;
  }

  @override
  String toString() {
    String requirement;
    if(howManyTimesLeft!=0){
      requirement = "\n-You have to focus $_minutes minutes for $_times time(s).\n";
    }else{
       requirement = "\n-You have to focus $_minutes minutes for $_times time(s).[✓]\n";
    }

    return requirement;
  }

}