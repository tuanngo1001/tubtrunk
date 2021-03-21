class UserModel {
  int uID;
  String name;
  String password;
  String email;
  int prize;

  //Constructor
  UserModel(this.name, this.password, this.email, this.prize);

  UserModel.forNow({this.uID, this.name, this.email, this.prize});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel.forNow(
      uID: json['ID'],
      name: json['UserName'],
      email: json['Email'],
      prize: json['Prize']
    );
  }
}
