import 'package:audioplayer2/audioplayer2.dart';
import 'package:flutter_first_app/model/radio_record_channel.dart';
import 'package:flutter_first_app/model/radio_record_channel_name.dart';

class RadioRecordPlayer {
  AudioPlayer _player = new AudioPlayer();
  RadioRecordChannel channel;


  RadioRecordPlayer() {
    channel = new RadioRecordChannel();
    channel.radioRecordChannelName = RadioRecordChannelName.RADIO_RECORD;
  }

  void play(RadioRecordChannel channelName) {
    channel = channelName;
    _player.play(channelName.urlToAudioStream);
  }

  void pause() => _player.pause();

  void stop() => _player.stop();
}