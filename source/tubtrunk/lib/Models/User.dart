import 'package:tubtrunk/Models/Reward.dart';

class User
{
  String _name;
  String _password;
  String _email;
  List<Reward> _rewardList;


  //Constructor
  User(this._name, this._password, this._email)
  {
    this._rewardList = new List<Reward>();

  }

  void addReward(Reward theReward)
  {
    this._rewardList.add(theReward);
  }
}