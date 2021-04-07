import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicController {
  static MusicController _instance;
  static MusicController get instance {
    if (_instance == null) {
      _instance = MusicController._instantiate();
    }
    return _instance;
  }

  static String _baseRemoteUrl = "https://tubtrunk.tk/musics/";

  AudioPlayer _advancedPlayer;
  List<List<String>> _musicList = [];
  Timer playingDemoTimer;

  MusicController._instantiate(){
    _advancedPlayer = new AudioPlayer();
    _loadMusics();
  }

  void _loadMusics(){
    _musicList.add(["Lofi Soundtrack", "lofi-music.mp3", "naruto-lofi.png"]);
    _musicList.add(["Relaxing Rain Soundtrack", "Relaxing-Rain.mp3","Relaxing-Rain.png"]);
    _musicList.add(["Billy Joel Song", "TheLongestTime.mp3","TheLongestTime.png"]);
    _musicList.add(["Hollow Knight Lo-Fi", "HollowKnight-lofi.mp3","HollowKnight.png"]);
    _musicList.add(["Mosquito Soundtrack", "MosquitoSoundEffect.mp3","mosquito.png"]);
    _musicList.add(["Just Do It", "JustDoIt.mp3","JustDoIt.png"]);
  }

  void playRemote(String fileName){
    stop();

    _advancedPlayer.play(_baseRemoteUrl + fileName);
    playingDemoTimer = Timer(Duration(seconds: 15), () => _advancedPlayer.stop()); // Only play 15 seconds for demos
  }

  void stop(){
    _advancedPlayer.stop();
    playingDemoTimer?.cancel();
  }

  void pause(){
    _advancedPlayer.pause();
  }

  void resume(){
    _advancedPlayer.resume();
  }

  List<List<String>> getMusics(){
    return _musicList;
  }

  void removeMusicAtIndex(int index){
    _musicList.removeAt(index);
  }

  int getMusicPrice(){
    return 99;
  }
}