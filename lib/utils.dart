import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class Utils {
  String name;
  Color color;

  Utils({this.name, this.color});

  static void shareApp() async {
    try {
      WcFlutterShare.share(
        sharePopupTitle: "Share App",
        subject: 'Tic Tac Toe Game',
        text:
            "Download Tic Tac Toe Game\n\nApp Link : https://play.google.com/store/apps/developer?id=Akshit+Zatakia\n\nTic Tac Toe is Free classic puzzle game also known as 'noughts or crosses' or sometimes 'X and O'.\nOur free Tic Tac Toe game offers:\n✓ 2 players game (multiplayer)\n✓ Play with bot\n✓ Choose your color\n\nDeveloped by : Akshit Zatakia (9375126826)\n\nWebsite : http://iplextechnologies.000webhostapp.com/",
        //fileName: "Tic Tac Toe.jpg",
        //bytesOfFile: bytes.buffer.asUint8List(),
        mimeType: 'text/plain',
      );
    } catch (e) {
      print(e);
    }
  }

  static void shareRating() async {
    var url = "https://play.google.com/store/apps/developer?id=Akshit+Zatakia";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
