import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tubtrunk/Controllers/music_controller.dart';
import 'package:tubtrunk/Models/music_model.dart';

class OwnedMusicsView extends StatefulWidget {
  @override
  _OwnedMusicsViewState createState() => _OwnedMusicsViewState();
}

class _OwnedMusicsViewState extends State<OwnedMusicsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Library'),
        backgroundColor: Color(0xfff97c7c),
      ),
      body: SafeArea(
        child: FutureBuilder<ListView>(
          future: _getOwnedMusics(),
          builder: (BuildContext context, AsyncSnapshot<ListView> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            }
            else {
              return Container(width: 0.0, height: 0.0);
            }
          },
        ),
      ),
    );
  }

  Future<ListView> _getOwnedMusics() async {
    List<MusicModel> ownedMusics = await MusicController.loadOwnedMusics();
    return ListView.builder(
      itemCount: ownedMusics.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: GestureDetector(
            onTap: () => MusicController.playLooping(ownedMusics[index].fileName),
            child: Text(
              ownedMusics[index].title,
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}