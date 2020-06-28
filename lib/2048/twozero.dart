import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';

import '../main.dart';
import 'board.dart';
import 'logic/game.dart';

class TwoZero extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TwoZero();
  }
}

class _TwoZero extends State<TwoZero> {
  Game game;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    game = new Game(4);
    super.initState();
  }

  Future<String> getHighScore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    int score = sharedPreferences.getInt('high_score');
    if (score == null) {
      score = 0;
    }
    return score.toString();
  }

  Widget _buildHighScoreWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.black87,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              'High Score',
              style: TextStyle(
                fontFamily: 'hs_us',
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder<String>(
              future: getHighScore(),
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data,
                    style: TextStyle(
                      fontFamily: 'hs_us',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text(
                    '0',
                    style: TextStyle(
                      fontFamily: 'hs_us',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBackWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: game.canUndo() ? Colors.black87 : Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: GestureDetector(
          child: Text(
            'Undo',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'hs_us',
              color: Color(0xff1f5c71),
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            setState(() {
              game.stepBack();
            });
          },
        ),
      ),
    );
  }

  Widget _buildScoreWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: Text(
              'Score',
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'hs_us',
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
            child: Text(
              '${game.getScore()}',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'hs_us',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  void updateHighScore() {
    int sc = sharedPreferences.getInt('high_score');
    if (sc == null) {
      sharedPreferences.setInt('high_score', game.getScore());
    } else {
      if (game.getScore() > sc) {
        sharedPreferences.setInt('high_score', game.getScore());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width - 80) / game.gridSize;
//    double gridHeight = gridWidth;
//    double height = 30 + (gridHeight * game.gridSize) + 10;

    return Scaffold(
      backgroundColor: Color(0xff1f5c71),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBackWidget(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 8.0),
                      _buildScoreWidget(),
                    ],
                  ),
                  _buildHighScoreWidget(),
                ],
              ),
            ),
            Expanded(
              child: SwipeDetector(
                swipeConfiguration: SwipeConfiguration(
                  verticalSwipeMinVelocity: 200.0,
                  verticalSwipeMinDisplacement: 50.0,
                  verticalSwipeMaxWidthThreshold: 200.0,
                  horizontalSwipeMaxHeightThreshold: 200.0,
                  horizontalSwipeMinDisplacement: 50.0,
                  horizontalSwipeMinVelocity: 200.0,
                ),
                onSwipeLeft: () {
                  game.moveLeft();
                  setState(() {
                    updateHighScore();
                  });
                },
                onSwipeRight: () {
                  game.moveRight();
                  setState(() {
                    updateHighScore();
                  });
                },
                onSwipeUp: () {
                  game.moveUp();
                  setState(() {
                    updateHighScore();
                  });
                },
                onSwipeDown: () {
                  game.moveDown();
                  setState(() {
                    updateHighScore();
                  });
                },
                child: Column(
                  children: <Widget>[
                    Board(game, gridWidth),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              color: Colors.blue[700],
              child: Text("RESTART",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'BlackOpsOne',
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                game.resetGame();
              },
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                color: Colors.blue[700],
                child: Text("HOME",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'BlackOpsOne',
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()))),
          ],
        ),
      ),
    );
  }
}
