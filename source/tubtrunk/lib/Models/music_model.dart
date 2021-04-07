class MusicModel {
  int id;
  String title;
  String fileName;

  MusicModel({this.id, this.title, this.fileName}) {}

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['ID'],
      title: json['Title'],
      fileName: json['FileName'],
    );
  }
}