import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:tic_tac_toe/mulitdata.dart';
import 'package:tic_tac_toe/single_player.dart';

class Ask extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tic Tac Toe",
              style: TextStyle(
                  color: Colors.green[400],
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Monoton'),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: NiceButton(
                elevation: 8.0,
                background: Colors.green[400],
                text: "Single Player",
                textColor: Colors.white,
                radius: 50,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SinglePlayer(),
                      ));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: NiceButton(
                elevation: 8.0,
                text: "Multiplayer",
                background: Colors.green[400],
                textColor: Colors.white,
                radius: 50,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Multidata(),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
