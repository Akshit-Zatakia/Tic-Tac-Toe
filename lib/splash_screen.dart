import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ask_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UI(),
    );
  }
}

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _goToNextScreen() async {
    Timer(
        Duration(milliseconds: 2000),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Ask(),
            )));
  }

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print("onLaunch called");
      },
      onResume: (Map<String, dynamic> msg) {
        print("onResume called");
      },
      onMessage: (Map<String, dynamic> msg) {
        print("onMessage called");
      },
    );
    _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      alert: true,
      badge: true,
    ));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('IOS');
    });
    _firebaseMessaging.getToken().then((token) {
      update(token);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _goToNextScreen());
  }

  update(String token) {
    print(token);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Container(
        color: Colors.grey[800],
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage('assets/logo.png'),
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Tic Tac Toe",
                style: TextStyle(
                    color: Colors.green[400],
                    fontFamily: 'Monoton',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
