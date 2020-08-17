import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: UI(),
    );
  }
}

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  Future<void> _launched;

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "About Us",
            style: TextStyle(
                fontFamily: 'Changa', fontSize: 40, color: Colors.green[400]),
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
        color: Colors.grey[800],
        child: ListView(
          padding: EdgeInsets.all(8.0),
          shrinkWrap: true,
          children: <Widget>[
            Card(
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/logo.png'),
                              width: 80,
                              height: 80,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Tic Tac Toe",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monoton'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Version 1.0",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Made with 💖. ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'Changa',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Text(
                      "Tic Tac Toe is Free classic puzzle game also known as 'noughts or crosses' or sometimes 'X and O'.\nOur free Tic Tac Toe game offers:\n✓ 2 players game (multiplayer)\n✓ Play with bot\n✓ Choose your color",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Changa',
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Divider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _launched = _launchURL(
                                'http://iplextechnologies.000webhostapp.com/');
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.language,
                              color: Colors.green[200],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                            Text(
                              'Visit Our Website',
                              style: TextStyle(
                                color: Colors.green[200],
                                fontFamily: 'ALice',
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _launched = _launchURL('tel:9375126826');
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              color: Colors.green[200],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                            Text(
                              '9375126826',
                              style: TextStyle(
                                  color: Colors.green[200],
                                  fontFamily: 'Alice',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                            Text(
                              '©2020 Akshit Zatakia.\n All Rights Reserved.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Alice',
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
