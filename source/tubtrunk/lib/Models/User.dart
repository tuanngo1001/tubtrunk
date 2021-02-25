
class User
{
  int uID;
  String name;
  String password;
  String email;

  //Constructor
  User(this.name, this.password, this.email);

  User.forNow({this.uID, this.name, this.email}){
  }

  factory User.fromJson(Map< String, dynamic> json){
    return User.forNow(
      uID: int.parse(json['uID']),
      name: json['Name'],
      email: json['uEmail'],
    );
  }

}