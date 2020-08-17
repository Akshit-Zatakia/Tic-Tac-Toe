import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/about.dart';
import 'package:tic_tac_toe/custom_dialog.dart';
import 'package:tic_tac_toe/game_button.dart';
import 'package:tic_tac_toe/utils.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;
  String name;
  Color color;
  int r, g, b, a;

  setValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      name = preferences.getString("name");
      r = preferences.getInt("r");
      g = preferences.getInt("g");
      b = preferences.getInt("b");
      a = preferences.getInt("a");
    });
    preferences.remove('name');
    preferences.remove('r');
    preferences.remove('g');
    preferences.remove('b');
    preferences.remove('a');
  }

  @override
  void initState() {
    super.initState();
    setValue();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = List();
    player2 = List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];

    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Color.fromARGB(a, r, g, b);
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "0";
        gb.bg = Colors.yellow[700];
        activePlayer = 1;
        player2.add(gb.id);
      }

      gb.enabled = false;
      int winner = checkWinner();

      if (winner == -1) {
        if (buttonsList.every((element) => element.text != "")) {
          showDialog(
              context: context,
              builder: (_) =>
                  CustomDialog("Game Tied", "😄😄😄", resetGame)).then((value) {
            resetGame();
          });
        } else {
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = new List();
    var list = List.generate(9, (index) => index + 1);

    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((element) => element.id == cellID);
    playGame(buttonsList[i]);
  }

  int checkWinner() {
    var winner = -1;
    //row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    //row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    //row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    //col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    //col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    //col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                "🎉 Congratulations 🎉",
                (name.isNotEmpty) ? name + " won" : "Player 1" + " won",
                resetGame)).then((value) {
          resetGame();
        });
      } else {
        showDialog(
                context: context,
                builder: (_) =>
                    CustomDialog("🥺 You lost 🥺", "Bot won", resetGame))
            .then((value) {
          resetGame();
        });
      }
    }

    return winner;
  }

  void resetGame() {
    setState(() {
      if (Navigator.canPop(context)) Navigator.pop(context);
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "Tic Tac Toe",
            style: TextStyle(
                fontFamily: 'Monoton',
                fontSize: 24,
                color: Colors.green[400],
                fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.green[400]),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[800],
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Text(
                      'Tic Tac Toe',
                      style: TextStyle(
                          color: Colors.green[400],
                          fontFamily: 'Monoton',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      'Developed by : Akshit Zatakia',
                      style: TextStyle(
                          color: Colors.green[400],
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    "About Us",
                    style: TextStyle(
                        color: Colors.green[400],
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => About()));
                  },
                ),
              ),
              Divider(
                color: Colors.green,
              ),
              Container(
                child: ListTile(
                  title: Text(
                    "Share App",
                    style: TextStyle(
                        color: Colors.green[400],
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Utils.shareApp();
                  },
                ),
              ),
              Divider(
                color: Colors.green,
              ),
              Container(
                child: ListTile(
                  title: Text(
                    "Rate Us",
                    style: TextStyle(
                        color: Colors.green[400],
                        fontFamily: 'Changa',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Utils.shareRating();
                  },
                ),
              ),
              Divider(
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  /*Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, right: 10, left: 10),
                      child: Text(
                        "Tic Tac Toe",
                        style:
                            TextStyle(fontSize: 50, color: Colors.green[400]),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
                child: Text(
                  "Welcome " + ((name.isNotEmpty) ? name : "Player 1"),
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[400],
                      fontFamily: 'Changa'),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                ),
                itemCount: buttonsList.length,
                itemBuilder: (context, index) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: buttonsList[index].bg),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: RaisedButton(
                      onPressed: buttonsList[index].enabled
                          ? () => playGame(buttonsList[index])
                          : null,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        buttonsList[index].text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontFamily: 'Changa'),
                      ),
                      color: buttonsList[index].bg,
                      disabledColor: buttonsList[index].bg,
                    )),
              ),
            ),
            RaisedButton(
              child: Text(
                "Reset",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.green,
              padding: EdgeInsets.all(10.0),
              onPressed: resetGame,
            )
          ],
        ),
      ),
    );
  }
}
