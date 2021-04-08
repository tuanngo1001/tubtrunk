import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:tubtrunk/Models/music_model.dart';
import 'package:tubtrunk/Utils/global_settings.dart';
import 'package:http/http.dart' as http;

class MusicController {
  static String _baseRemoteUrl = "https://tubtrunk.tk/musics/";
  static AudioPlayer _advancedPlayer = new AudioPlayer();
  static Timer _playingDemoTimer;

  MusicController._(){}

  static void playDemo(String fileName){
    stop();
    _advancedPlayer.setReleaseMode(ReleaseMode.STOP);
    _advancedPlayer.play(_baseRemoteUrl + fileName);

    _playingDemoTimer = Timer(Duration(seconds: 15), () => _advancedPlayer.stop()); // Only play 15 seconds for demos
  }

  static void playLooping(String fileName) {
    stop();
    _advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
    _advancedPlayer.play(_baseRemoteUrl + fileName);
  }

  static void stop() {
    _advancedPlayer.stop();
    _playingDemoTimer?.cancel();
  }

  static void pause() {
    _advancedPlayer.pause();
  }

  static void resume() {
    _advancedPlayer.resume();
  }

  static Future<List<MusicModel>> loadOwnedMusic() async {
    List<MusicModel> ownedMusics = [];
    var map = new Map<String, String>();
    map["UserID"] = GlobalSettings.user.uID.toString();

    var response = await http.post(GlobalSettings.serverAddress + "getOwnedMusic.php", body: map);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var key in data) {
        ownedMusics.add(MusicModel.fromJson(key));
      }
    }

    return ownedMusics;
  }
}