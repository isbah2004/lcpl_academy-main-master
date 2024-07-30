import 'package:flutter/material.dart';
import 'package:lcpl_academy/screens/homescreen/tabs/audio_tab.dart';
import 'package:lcpl_academy/screens/homescreen/tabs/doc_tab.dart';
import 'package:lcpl_academy/screens/homescreen/tabs/quotes_tab.dart';
import 'package:lcpl_academy/screens/homescreen/tabs/video_tab.dart';

class Constants {
  static const String logo = 'assets/Lotte_Chemicals_Pak_Logo.png';
  static const String login = 'Login';
  static const String register = 'Signup';
   static const List<Widget> widgetOptions = <Widget>[
    DocumentsTab(),
    AudioTab(),
    QuotesTab(),
    VideoTab(),
  ]; static const String documents = 'Documents';
  static const String audios = 'Audios';
  static const String videos = 'videos';
  static const String quotes = 'Quotes';
}
