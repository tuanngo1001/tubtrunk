class UserModel {
  int uID;
  String name;
  String password;
  String email;

  //Constructor
  UserModel(this.name, this.password, this.email);

  UserModel.forNow({this.uID, this.name, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel.forNow(
      uID: int.parse(json['uID']),
      name: json['Name'],
      email: json['uEmail'],
    );
  }
}
