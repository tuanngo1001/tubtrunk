import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tubtrunk/Controllers/music_controller.dart';
import 'package:tubtrunk/Models/music_model.dart';

class MusicLibraryView extends StatefulWidget {
  @override
  _MusicLibraryViewState createState() => _MusicLibraryViewState();
}

class _MusicLibraryViewState extends State<MusicLibraryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Library'),
        backgroundColor: Color(0xfff97c7c),
      ),
      body: SafeArea(
        child: FutureBuilder<ListView>(
          future: _getOwnedMusic(),
          builder: (BuildContext context, AsyncSnapshot<ListView> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            } else {
              return Container(width: 0.0, height: 0.0);
            }
          },
        ),
      ),
    );
  }

  Future<ListView> _getOwnedMusic() async {
    List<MusicModel> ownedMusics = await MusicController.loadOwnedMusic();
    return ListView.builder(
      itemCount: ownedMusics.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Card(
            color: Colors.cyan.shade50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(IconData(0xe897, fontFamily: 'MaterialIcons')),
                Text(
                  ownedMusics[index].title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(IconData(0xe936, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      MusicController.playLooping(ownedMusics[index].fileName);
                    }),
                IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(IconData(0xe465, fontFamily: 'MaterialIcons')),
                    onPressed: () => {MusicController.stop()}),
              ],
            ),
          ),
        );
      },
    );
  }
}
