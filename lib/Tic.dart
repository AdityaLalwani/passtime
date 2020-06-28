import 'package:flutter/material.dart';

import 'main.dart';

class Tic extends StatefulWidget {
  @override
  _Tic createState() => _Tic();
}

class _Tic extends State<Tic> {
  static const double RADIUS_CORNER = 12;
  static const int NONE = 0;
  static const int VALUE_X = 1;
  static const int VALUE_O = 2;

  /// Theme game
  Color colorBackgroundChannelValueX = Colors.black54;
  Color colorChannelIcon = Colors.white;
  Color colorTextCurrentTurn = Colors.black;

  // State of Game
  List<List<int>> channelStatus = [
    [NONE, NONE, NONE],
    [NONE, NONE, NONE],
    [NONE, NONE, NONE],
  ];

  //
  int currentTurn = VALUE_X;
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xff1f5c71),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Icon(getIconFromStatus(currentTurn), size: 60, color: Colors.white),
            Container(
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                  color: Color(0xff1f5c71),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildRowChannel(0)),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildRowChannel(1)),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildRowChannel(2))
                ],
              ),
            ),
            SizedBox(
              height: 40,
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
                playAgain();
                x++;
                if (x % 2 == 1) {
                  currentTurn = VALUE_O;
                }
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
          ]),
        ),
      ),
    );
  }

  List<Widget> buildRowChannel(int row) {
    List<Widget> listWidget = List();
    for (int col = 0; col < 3; col++) {
      double tlRadius = row == 0 && col == 0 ? RADIUS_CORNER : 0;
      double trRadius = row == 0 && col == 2 ? RADIUS_CORNER : 0;
      double blRadius = row == 2 && col == 0 ? RADIUS_CORNER : 0;
      double brRadius = row == 2 && col == 2 ? RADIUS_CORNER : 0;
      Widget widget = buildChannel(row, col, tlRadius, trRadius, blRadius,
          brRadius, channelStatus[row][col]);
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildChannel(int row, int col, double tlRadius, double trRadius,
          double blRadius, double brRadius, int status) =>
      GestureDetector(
          onTap: () => onChannelPressed(row, col),
          child: Container(
              margin: EdgeInsets.all(2),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: getBackgroundChannelFromStatus(status),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(tlRadius),
                      topRight: Radius.circular(trRadius),
                      bottomLeft: Radius.circular(blRadius),
                      bottomRight: Radius.circular(brRadius))),
              child: Icon(
                getIconFromStatus(status),
                size: 60,
                color: Color(0xffe04251),
              )));

  IconData getIconFromStatus(int status) {
    if (status == VALUE_X) {
      return Icons.close;
    } else if (status == VALUE_O) {
      return Icons.radio_button_unchecked;
    }
    return null;
  }

  Color getBackgroundChannelFromStatus(int status) {
    if (status == VALUE_X) {
      return colorBackgroundChannelValueX;
    } else if (status == VALUE_O) {
      return Color(0xff1e3d3d);
    }
    return Colors.black45;
  }

  onChannelPressed(int row, int col) {
    if (channelStatus[row][col] == NONE) {
      setState(() {
        channelStatus[row][col] = currentTurn;

        if (isGameEndedByWin()) {
          showEndGameDialog(currentTurn);
        } else {
          if (isGameEndedByDraw()) {
            showEndGameByDrawDialog();
          } else {
            switchPlayer();
          }
        }
      });
    }
  }

  void switchPlayer() {
    setState(() {
      if (currentTurn == VALUE_X) {
        currentTurn = VALUE_O;
      } else if (currentTurn == VALUE_O) {
        currentTurn = VALUE_X;
      }
    });
  }

  bool isGameEndedByDraw() {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (channelStatus[row][col] == NONE) {
          return false;
        }
      }
    }
    return true;
  }

  bool isGameEndedByWin() {
    // check vertical.
    for (int col = 0; col < 3; col++) {
      if (channelStatus[0][col] != NONE &&
          channelStatus[0][col] == channelStatus[1][col] &&
          channelStatus[1][col] == channelStatus[2][col]) {
        return true;
      }
    }

    // check horizontal.
    for (int row = 0; row < 3; row++) {
      if (channelStatus[row][0] != NONE &&
          channelStatus[row][0] == channelStatus[row][1] &&
          channelStatus[row][1] == channelStatus[row][2]) {
        return true;
      }
    }

    // check cross left to right.
    if (channelStatus[0][0] != NONE &&
        channelStatus[0][0] == channelStatus[1][1] &&
        channelStatus[1][1] == channelStatus[2][2]) {
      return true;
    }

    // check cross right to left.
    if (channelStatus[0][2] != NONE &&
        channelStatus[0][2] == channelStatus[1][1] &&
        channelStatus[1][1] == channelStatus[2][0]) {
      return true;
    }

    return false;
  }

  void showEndGameDialog(int winner) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("The winner is",
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'hs_us',
                  color: Color(0xff3B7080),
                  fontWeight: FontWeight.bold)),
          Icon(getIconFromStatus(currentTurn),
              size: 60, color: Color(0xff3B7080)),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            color: Color(0xffe04251),
            child: Text("Play again",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'hs_us',
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              playAgain();
              x++;
              if (x % 2 == 1) {
                currentTurn = VALUE_O;
              }
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              color: Color(0xffe04251),
              child: Text("HOME",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'hs_us',
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()))),
        ]));
      },
    );
  }

  void showEndGameByDrawDialog() {
    // flutter defined function
    showDialog(
      barrierColor: Color(0xffebe9d8),
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Draw",
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'hs_us',
                  color: Color(0xff3B7080),
                  fontWeight: FontWeight.bold)),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            color: Color(0xffe04251),
            child: Text("Play again",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'hs_us',
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              playAgain();
              x++;
              if (x % 2 == 1) {
                currentTurn = VALUE_O;
              }
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              color: Color(0xffe04251),
              child: Text("HOME",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'hs_us',
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()))),
        ]));
      },
    );
  }

  playAgain() {
    setState(() {
      currentTurn = VALUE_X;
      channelStatus = [
        [NONE, NONE, NONE],
        [NONE, NONE, NONE],
        [NONE, NONE, NONE],
      ];
    });
  }
}
