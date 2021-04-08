import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrunk/Models/music_model.dart';

void main() {
  test("Properties of created music should match with given inputs", () {
    MusicModel parsedMission = MusicModel(
      id: 1,
      title: "Music",
      fileName: "test.mp3",
    );

    expect(parsedMission.id, 1);
    expect(parsedMission.title, "Music");
    expect(parsedMission.fileName, "test.mp3");
  });

  test("Properties of created music should match with given JSON Object", () {
    MusicModel parsedMission = MusicModel.fromJson({
      "ID": 2,
      "Title": "Music 2",
      "FileName": "test 2.mp3",
    });

    expect(parsedMission.id, 2);
    expect(parsedMission.title, "Music 2");
    expect(parsedMission.fileName, "test 2.mp3");
  });
}