import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

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
}