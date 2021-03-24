class LeaderboardModel {
  int uID;
  String name;
  int prize;
  double avgFocusTime;
  int totalFocusTime;
  int totalTimes;
  int totalPrize;


  //Constructor
  // LeaderboardModel(this.name, this.prize);

  LeaderboardModel.forNow({this.uID, this.name, this.prize, this.avgFocusTime, this.totalFocusTime, this.totalTimes, this.totalPrize});

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel.forNow(
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