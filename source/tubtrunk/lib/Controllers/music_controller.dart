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

  AudioPlayer _advancedPlayer;
  AudioCache _audioCache;
  List<List<String>> _musicList = [];

  MusicController._instantiate(){
    _advancedPlayer = new AudioPlayer();
    _audioCache = new AudioCache(fixedPlayer: _advancedPlayer, prefix:'assets/musics/');
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

  void play(String url, {bool isDemo = true}){
    stop();

    _advancedPlayer.play(url);
    // _audioCache.play(fileName,volume: 100.0);

    if (isDemo) {
      Future.delayed(Duration(seconds: 15), () => _advancedPlayer.stop()); // Only play 10 seconds for demos
    }
  }

  void stop(){
    _advancedPlayer.stop();
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