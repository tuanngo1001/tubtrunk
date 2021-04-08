class LeaderboardModel{
  int uID;
  String name;
  int prize;
  double avgFocusTime;
  int totalFocusTime;
  int totalTimes;
  int totalPrize;

  LeaderboardModel({this.uID, this.name, this.prize, this.avgFocusTime, this.totalFocusTime, this.totalTimes, this.totalPrize});

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
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