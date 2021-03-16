import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController{

  static final AudioController theOnlyAudioController = AudioController._initializerFunction();
  static AudioPlayer advancedPlayer;
  static AudioCache audioCache;
  static List<List<String>> musicList = new List<List<String>>();

  factory AudioController(){
    return theOnlyAudioController;
  }

  AudioController._initializerFunction(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer, prefix:'assets/musics/');
    loadMusics();
  }
  void playByName(String songName,[int duration]){
    stopCurrentSong();
    advancedPlayer.setVolume(1.0);
    audioCache.play(songName,volume: 3.0);
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

  void loadMusics(){
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
}