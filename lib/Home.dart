import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passtime/Tetris.dart';
import 'package:passtime/sudoku.dart';

import '2048/twozero.dart';
import 'Snake.dart';
import 'Tic.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        //1 snake
        Card(
          elevation: 20.0,
          color: Color(0xfff4f4f0),
          shadowColor: Color(0xfff4f4f0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Snake())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/images/snake.gif",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            "SNAKE",
            style: GoogleFonts.blackOpsOne(
                textStyle: TextStyle(
              color: Colors.grey,
              fontSize: 32,
            )),
          ),
        ),
        //2 tic tac toe
        Card(
          elevation: 20.0,
          color: Color(0xfff4f4f0),
          shadowColor: Color(0xfff4f4f0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Tic())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/images/tic.gif",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            "TICTACTOE",
            style: GoogleFonts.blackOpsOne(
                textStyle: TextStyle(
              color: Colors.grey,
              fontSize: 32,
            )),
          ),
        ),
        //3 sudoku
        Card(
          elevation: 20.0,
          color: Color(0xfff4f4f0),
          shadowColor: Color(0xfff4f4f0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Sudoku())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/images/sudoku.gif",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            "SUDOKU",
            style: GoogleFonts.blackOpsOne(
                textStyle: TextStyle(
              color: Colors.grey,
              fontSize: 32,
            )),
          ),
        ),
        //4 2048
        Card(
          elevation: 20.0,
          color: Color(0xfff4f4f0),
          shadowColor: Color(0xfff4f4f0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TwoZero())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/images/2048.gif",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            "2048",
            style: GoogleFonts.blackOpsOne(
                textStyle: TextStyle(
              color: Colors.grey,
              fontSize: 32,
            )),
          ),
        ),
        //5 tetris
        Card(
          elevation: 20.0,
          color: Color(0xfff4f4f0),
          shadowColor: Color(0xfff4f4f0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Tetris())),
                child: ClipRRect(
                  child: Image.asset(
                    "assets/images/tetris.gif",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            "TETRIS",
            style: GoogleFonts.blackOpsOne(
                textStyle: TextStyle(
              color: Colors.grey,
              fontSize: 32,
            )),
          ),
        ),
      ],
    ));
  }
}
