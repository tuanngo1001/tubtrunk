import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController{

  static final AudioController theOnlyAudioController = AudioController._initializerFunction();
  static AudioPlayer advancedPlayer;
  static AudioCache audioCache;
  static List<List<String>> musicList = [];

  factory AudioController(){
    return theOnlyAudioController;
  }

  AudioController._initializerFunction(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer, prefix:'assets/musics/');
    _loadMusics();
  }

  void playByName(String songName,[int duration]){
    stopCurrentSong();
    advancedPlayer.setVolume(100.0);
    audioCache.play(songName,volume: 100.0);
    if(duration !=null){
      Future.delayed(Duration(seconds: duration), () => advancedPlayer.stop());
    }
  }

  void stopCurrentSong(){
    advancedPlayer.stop();
  }

  void pauseCurrentSong(){
    advancedPlayer.pause();
  }

  void resumeCurrentSong(){
    advancedPlayer.resume();
  }

  void _loadMusics(){
    musicList.add(["Lofi Soundtrack", "Naruto_lofi.mp3", "naruto-lofi.png"]);
    musicList.add(["Relaxing Rain Soundtrack", "Relaxing-Rain.mp3","Relaxing-Rain.png"]);
    musicList.add(["Billy Joel Song", "TheLongestTime.mp3","TheLongestTime.png"]);
    musicList.add(["Hollow Knight Lo-Fi", "HollowKnight-lofi.mp3","HollowKnight.png"]);
    musicList.add(["Mosquito Soundtrack", "MosquitoSoundEffect.mp3","mosquito.png"]);
    musicList.add(["Just Do It", "JustDoIt.mp3","JustDoIt.png"]);
  }

  List<List<String>> getMusics(){
    return musicList;
  }

  void removeMusicAtIndex(int index){
    musicList.removeAt(index);
  }

  int getMusicPrice(){
    return 99;
  }
}