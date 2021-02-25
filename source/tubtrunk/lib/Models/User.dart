import 'package:tubtrunk/Models/Reward.dart';

class User
{
  int uID;
  String name;
  String password;
  String email;
  List<Reward> _rewardList;

  //Constructor
  User(this.name, this.password, this.email);

  User.forNow({this.uID, this.name, this.email}){
    this._rewardList = new List<Reward>();
  }

  factory User.fromJson(Map< String, dynamic> json){
    return User.forNow(
      uID: int.parse(json['uID']),
      name: json['Name'],
      email: json['uEmail'],
    );
  }

  void addReward(Reward theReward)
  {
    this._rewardList.add(theReward);
  }
}