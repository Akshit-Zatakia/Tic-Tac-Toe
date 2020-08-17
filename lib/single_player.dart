import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:tic_tac_toe/utils.dart';
import 'package:tic_tac_toe/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SinglePlayer extends StatelessWidget {
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
  Color pickerColor = Colors.green[400];
  TextEditingController name = TextEditingController();
  Utils utils;

  void onChangeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  setValue() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name.text);
    var r = pickerColor.red;
    var g = pickerColor.green;
    var b = pickerColor.blue;
    var a = pickerColor.alpha;
    prefs.setInt("r", r);
    prefs.setInt("g", g);
    prefs.setInt("b", b);
    prefs.setInt("a", a);
    print(prefs.getString('name'));
  }

  playGame() {
    setValue();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MyApp(),
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
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Enter your name',
                    labelStyle: TextStyle(
                        color: Colors.green[400],
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold)),
                controller: name,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(11),
                  child: Text(
                    "Select Your Color :",
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
                            backgroundColor: Colors.grey[800],
                            title: Text(
                              "Select Color",
                              style: TextStyle(
                                  fontFamily: 'Changa',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[400]),
                            ),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: pickerColor,
                                onColorChanged: onChangeColor,
                              ),
                            ),
                          );
                        });
                  },
                  color: pickerColor,
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
                radius: 50,
                width: 200,
                onPressed: playGame,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
