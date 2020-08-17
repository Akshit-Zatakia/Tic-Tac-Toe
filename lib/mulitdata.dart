import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:tic_tac_toe/multiplayer.dart';
import 'package:tic_tac_toe/utils.dart';
import 'package:tic_tac_toe/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Multidata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green[400]),
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
  Color pickerColor1 = Colors.red[400];
  Color pickerColor2 = Colors.yellow[700];
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();
  Utils utils;

  void onChangeColor1(Color color) {
    setState(() {
      pickerColor1 = color;
    });
  }

  void onChangeColor2(Color color) {
    setState(() {
      pickerColor2 = color;
    });
  }

  setValue() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name1", name1.text);
    prefs.setString("name2", name2.text);
    var r1 = pickerColor1.red;
    var g1 = pickerColor1.green;
    var b1 = pickerColor1.blue;
    var a1 = pickerColor1.alpha;
    prefs.setInt("r1", r1);
    prefs.setInt("g1", g1);
    prefs.setInt("b1", b1);
    prefs.setInt("a1", a1);
    var r2 = pickerColor2.red;
    var g2 = pickerColor2.green;
    var b2 = pickerColor2.blue;
    var a2 = pickerColor2.alpha;
    prefs.setInt("r2", r2);
    prefs.setInt("g2", g2);
    prefs.setInt("b2", b2);
    prefs.setInt("a2", a2);
    //print(prefs.getString('name'));
  }

  playGame() {
    setValue();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MultiPlayer(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                "Tic Tac Toe",
                style: TextStyle(
                    color: Colors.green[400],
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monoton'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                cursorColor: Colors.green[400],
                style: TextStyle(
                    color: Colors.green[400],
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    labelText: 'Enter Player 1 Name',
                    labelStyle: TextStyle(
                        color: Colors.green[400],
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold)),
                controller: name1,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(11),
                  child: Text(
                    "Select Player 1 Color :",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green[400],
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                RaisedButton(
                  child: Text(""),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Select Color"),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: pickerColor1,
                                onColorChanged: onChangeColor1,
                              ),
                            ),
                          );
                        });
                  },
                  color: pickerColor1,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                cursorColor: Colors.green[400],
                style: TextStyle(
                    color: Colors.green[400],
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    labelText: 'Enter Player 2 Name',
                    labelStyle: TextStyle(
                        color: Colors.green[400],
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold)),
                controller: name2,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(11),
                  child: Text(
                    "Select Player 2 Color :",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green[400],
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                RaisedButton(
                  child: Text(""),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Select Color"),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: pickerColor2,
                                onColorChanged: onChangeColor2,
                              ),
                            ),
                          );
                        });
                  },
                  color: pickerColor2,
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: NiceButton(
                background: Colors.white,
                text: 'Play Game',
                textColor: Colors.green[400],
                width: 200,
                radius: 50,
                onPressed: playGame,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
