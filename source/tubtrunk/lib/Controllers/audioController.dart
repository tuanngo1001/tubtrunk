import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController{

  static final AudioController theOnlyAudioController = AudioController._initializerFunction();
  static AudioPlayer advancedPlayer;
  static AudioCache audioCache;


  factory AudioController(){
    return theOnlyAudioController;
  }

  AudioController._initializerFunction(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer, prefix:'assets/musics/');
  }

  void playByName(String songName,[int duration]){
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



}