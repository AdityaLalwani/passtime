import 'dart:io';

import 'package:flutter/material.dart';
import 'package:passtime/2048/twozero.dart';
import 'package:passtime/Snake.dart';
import 'package:passtime/Tetris.dart';
import 'package:passtime/Tic.dart';
import 'package:passtime/sudoku.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'PASS TIME'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff003399),
        appBar: AppBar(
          backgroundColor: Color(0xff003399),
          title: Center(
              child: Text(
            widget.title,
            style: GoogleFonts.blackOpsOne(
                textStyle: TextStyle(
              color: Colors.grey,
              fontSize: 32,
            )),
          )),
          actions: [
            FlatButton(
                onPressed: () {
                  exit(0);
                },
                child: Image.asset("assets/images/close.jpg"))
          ],
        ),
        drawer: SizedBox(
          width: 105.0,
          child: Drawer(
            child: Row(
              children: [
                NavigationRail(
                  backgroundColor: Color(0xff0061fc),
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  groupAlignment: 1.0,
                  labelType: NavigationRailLabelType.all,
                  leading: Column(
                    children: <Widget>[
//                  CircleAvatar(
//                    backgroundImage: AssetImage(''),
//                  ),
//                      SizedBox(height: 20),
                    ],
                  ),
                  destinations: [
                    NavigationRailDestination(
                      icon: SizedBox.shrink(),
                      label: RotatedBox(
                        quarterTurns: -1,
                        child: RaisedButton(
                            padding: EdgeInsets.all(1),
                            child: Text(
                              "Home",
                              style: GoogleFonts.abel(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                            ),
                            color: Color(0xffdb3c07),
                            elevation: 10.0,
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                    ),
                    NavigationRailDestination(
                        icon: SizedBox.shrink(),
                        label: RotatedBox(
                          quarterTurns: -1,
                          child: RaisedButton(
                              padding: EdgeInsets.all(1),
                              child: Text(
                                "Snake",
                                style: GoogleFonts.abel(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                              ),
                              color: Colors.redAccent,
                              elevation: 10.0,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Snake()))),
                        )),
                    NavigationRailDestination(
                        icon: SizedBox.shrink(),
                        label: RotatedBox(
                          quarterTurns: -1,
                          child: RaisedButton(
                              padding: EdgeInsets.all(1),
                              child: Text(
                                "Tic Tac Toe",
                                style: GoogleFonts.abel(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                              ),
                              color: Colors.redAccent,
                              elevation: 10.0,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Tic()))),
                        )),
                    NavigationRailDestination(
                        icon: SizedBox.shrink(),
                        label: RotatedBox(
                          quarterTurns: -1,
                          child: RaisedButton(
                              padding: EdgeInsets.all(1),
                              child: Text(
                                "2048",
                                style: GoogleFonts.abel(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                              ),
                              color: Colors.redAccent,
                              elevation: 10.0,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TwoZero()))),
                        )),
                    NavigationRailDestination(
                        icon: SizedBox.shrink(),
                        label: RotatedBox(
                          quarterTurns: -1,
                          child: RaisedButton(
                              padding: EdgeInsets.all(1),
                              child: Text(
                                "Sudoku",
                                style: GoogleFonts.abel(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                              ),
                              color: Colors.redAccent,
                              elevation: 10.0,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Sudoku()))),
                        )),
                    NavigationRailDestination(
                        icon: SizedBox.shrink(),
                        label: RotatedBox(
                          quarterTurns: -1,
                          child: RaisedButton(
                              padding: EdgeInsets.all(1),
                              child: Text(
                                "Tetris",
                                style: GoogleFonts.abel(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                              ),
                              color: Colors.redAccent,
                              elevation: 10.0,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Tetris()))),
                        )),
                    NavigationRailDestination(
                      icon: FlatButton(
                          padding: EdgeInsets.all(1),
                          child: Image.asset("assets/images/close.jpg"),
                          onPressed: () => exit(0)),
                      label: RotatedBox(
                        quarterTurns: -1,
//                        child: FlatButton(
//                            padding: EdgeInsets.all(1),
//                            child: Image.asset("assets/images/close.jpg"),
//                            onPressed: () => exit(0)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: HomePage());
  }
}
