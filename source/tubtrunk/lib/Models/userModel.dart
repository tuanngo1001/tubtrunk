class UserModel {
  int uID;
  String name;
  String password;
  String email;
  int prize;
  double avgFocusTime;
  int totalFocusTime;
  int totalTimes;
  int totalPrize;


  //Constructor
  UserModel(this.name, this.password, this.email, this.prize);

  UserModel.forNow({this.uID, this.name, this.prize, this.avgFocusTime, this.totalFocusTime, this.totalTimes, this.totalPrize});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel.forNow(
      uID: json['ID'],
      name: json['UserName'],
      prize: json['Prize'],
      avgFocusTime: json['AverageMinutes']/1,
      totalFocusTime: json['TotalMinutes'],
      totalTimes: json['TotalTimes'],
      totalPrize: json['TotalPrize']
    );
  }
}
