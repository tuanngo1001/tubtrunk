class UserModel {
  int uID;
  String username;
  String password;
  String email;
  String token;
  int money;

  //Constructor
  UserModel(this.username, this.password, this.email, this.token, this.money);

  UserModel.forNow({this.uID, this.username, this.email, this.password, this.token, this.money});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel.forNow(
      uID: int.parse(json['uID']),
      username: json['uUserName'],
      email: json['uEmail'],
      password: json['uPassword'],
      token: json['uToken'],
      money: int.parse(json['uMoney']),
    );
  }
}
