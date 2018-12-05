import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_first_app/model/radio_record_channel.dart';
import 'package:flutter_first_app/model/radio_record_player.dart';
import 'package:flutter_first_app/model/radio_record_song_provider.dart';

class HomePage extends StatefulWidget {

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RadioRecordSongProvider _provider;
  RadioRecordPlayer _player;


  @override
  void initState() {
    super.initState();
    _provider = new RadioRecordSongProvider();
    _player = new RadioRecordPlayer();
    Timer.periodic(Duration(seconds: 5), (timer) =>
        setState(() {
          _provider.updateSongByCurrentChannel();
        }));
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    var iterableElements = _provider.radioRecordChannels.values;
    var channelList = iterableElements.toList();
    channelList.sort((c1, c2) => c1.channelName.compareTo(c2.channelName));

    for (int i = 0; i < iterableElements.length; i++) {
      var channel = channelList[i];
      print(channel.channelName);
      var backgroundColor = channel.channelName.toString() == _player.channel.channelName.toString()
          ? Colors.black38
          : Colors.white;

      drawerOptions.add(
        Container(
            decoration: BoxDecoration(color: backgroundColor),
            child: ListTile(
              title: Text(channel.channelName, style: TextStyle(color: Color(0xFF212121)),
              ),
              onTap: () => _onSelectItem(channel),
            )
        ),
      );
    }


    return new Scaffold(
      appBar: AppBar(
        title: Text("AudioPlayer"),
        backgroundColor: Color(0xFF212121),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF212121)),
              child: Center(
                child: Text(_provider
                    .getCurrentChannel()
                    .channelName,
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            Column(children: drawerOptions)
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => _player.play(_provider.getCurrentChannel()),
        onDoubleTap: () => _player.pause(),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        _provider.currentSong.image ??
                            ""
                    ),
                    fit: BoxFit.fitHeight
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.75)),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Card(
                    shape: Border.all(color: Colors.white, width: 2.0, style: BorderStyle.solid),
                    child: Image.network(
                        _provider.currentSong.image ??
                            ""),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _provider.currentSong.title ?? _provider
                          .getCurrentChannel()
                          .channelName,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _provider.currentSong.artist ?? _provider
                          .getCurrentChannel()
                          .channelName,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _onSelectItem(RadioRecordChannel channel) {
    setState(() {
      _provider.currentChannel = channel.radioRecordChannelName;
      _player.stop();
      _player.play(_provider.getCurrentChannel());
    });
    Navigator.pop(context);
  }
}