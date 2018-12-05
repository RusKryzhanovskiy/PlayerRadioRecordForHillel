import 'dart:convert';

import 'package:flutter_first_app/model/radio_record_channel.dart';
import 'package:flutter_first_app/model/radio_record_channel_name.dart';
import 'package:flutter_first_app/model/radio_record_song.dart';
import 'package:http/http.dart' as http;

class RadioRecordSongProvider {
  Map<RadioRecordChannelName, RadioRecordChannel> _radioRecordChannels;

  RadioRecordChannelName _currentChannel;
  RadioRecordSong _currentSong;

  RadioRecordSongProvider() {
    _initSongMap();
    _initCurrentChannel();
  }

  Map<RadioRecordChannelName, RadioRecordChannel> get radioRecordChannels => _radioRecordChannels;

  RadioRecordSong get currentSong => _currentSong != null ? _currentSong : new RadioRecordSong();

  RadioRecordChannel getCurrentChannel() => _radioRecordChannels[_currentChannel];

  set currentChannel(RadioRecordChannelName value) {
    _currentChannel = value;
    updateSongByCurrentChannel();
  }

  void updateSongByCurrentChannel() async {
    RadioRecordChannel channel = _radioRecordChannels[_currentChannel];
    http.Response response = await http.get(channel.urlToInfo);
    _currentSong = _parseIntoHttpResponse(response);
  }

  RadioRecordSong _parseIntoHttpResponse(http.Response httpResponse) {
    String httpResponseBody = httpResponse.body;
    print(httpResponseBody);
    Map songMap = json.decode(httpResponseBody);
    return RadioRecordSong.fromJson(songMap);
  }

  void _initCurrentChannel() {
    _currentChannel = RadioRecordChannelName.RADIO_RECORD;
  }

  _initSongMap() {
    _radioRecordChannels = new Map();
    RadioRecordChannel radioRecordChannel = new RadioRecordChannel();
    radioRecordChannel.channelName = "Radio Record";
    radioRecordChannel.urlToInfo = "https://www.radiorecord.ru/xml/rr_online_v8.txt";
    radioRecordChannel.urlToAudioStream = "http://air.radiorecord.ru:805/rr_320";
    radioRecordChannel.radioRecordChannelName = RadioRecordChannelName.RADIO_RECORD;
    _radioRecordChannels[RadioRecordChannelName.RADIO_RECORD] = radioRecordChannel;

    RadioRecordChannel radioChillOutChannel = new RadioRecordChannel();
    radioChillOutChannel.channelName = "Chill-Out";
    radioChillOutChannel.urlToInfo = "https://www.radiorecord.ru/xml/chil_online_v8.txt";
    radioChillOutChannel.urlToAudioStream = "http://air.radiorecord.ru:805/chil_320";
    radioChillOutChannel.radioRecordChannelName = RadioRecordChannelName.CHILL_OUT;
    _radioRecordChannels[RadioRecordChannelName.CHILL_OUT] = radioChillOutChannel;

    RadioRecordChannel radioTranceChannel = new RadioRecordChannel();
    radioTranceChannel.channelName = "Trance";
    radioTranceChannel.urlToInfo = "https://www.radiorecord.ru/xml/trancehits_online_v8.txt";
    radioTranceChannel.urlToAudioStream = "http://air.radiorecord.ru:805/trancehits_320";
    radioTranceChannel.radioRecordChannelName = RadioRecordChannelName.TRANCE_HITS;
    _radioRecordChannels[RadioRecordChannelName.TRANCE_HITS] = radioTranceChannel;

    RadioRecordChannel radioRussianMixChannel = new RadioRecordChannel();
    radioRussianMixChannel.channelName = "Russian Mix";
    radioRussianMixChannel.urlToInfo = "https://www.radiorecord.ru/xml/rus_online_v8.txt";
    radioRussianMixChannel.urlToAudioStream = "http://air.radiorecord.ru:805/rus_320";
    radioRussianMixChannel.radioRecordChannelName = RadioRecordChannelName.RUSSIAN_MIX;
    _radioRecordChannels[RadioRecordChannelName.RUSSIAN_MIX] = radioRussianMixChannel;
  }
}