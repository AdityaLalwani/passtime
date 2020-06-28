import 'dart:math';

import 'package:flutter/material.dart';

import 'main.dart';

const double RADIUS_CORNER = 12;
const int VALUE_NONE = 0;

const int COUNT_ROW_SUB_TABLE = 3;
const int COUNT_COL_SUB_TABLE = 3;

class Sudoku extends StatefulWidget {
  @override
  _Sudoku createState() => _Sudoku();
}

class SudokuChannel {
  bool enableMove;
  bool enableWarning;
  int value;

  SudokuChannel(
      {this.value = 0, this.enableMove = true, this.enableWarning = false});
}

class SudokuSubTable {
  int indexRowInTable;
  int indexColInTable;
  List<List<SudokuChannel>> subTable;

  SudokuSubTable({this.indexRowInTable, this.indexColInTable});

  init() {
    subTable = List();
    for (int row = 1; row <= COUNT_ROW_SUB_TABLE; row++) {
      List<SudokuChannel> list = List();
      for (int col = 1; col <= COUNT_COL_SUB_TABLE; col++) {
        list.add(SudokuChannel(value: 0));
      }
      subTable.add(list);
    }
  }

  setValue({int row = 0, int col = 0, int value = 0, bool enableMove = true}) {
    subTable[row][col] = SudokuChannel(value: value, enableMove: enableMove);
  }

  int randomNumber() {
    Random r = Random();
    return r.nextInt(10);
  }
}

class SudokuTable {
  List<List<SudokuSubTable>> table;

  init() {
    table = List();
    for (int row = 0; row < COUNT_ROW_SUB_TABLE; row++) {
      List<SudokuSubTable> list = List();
      for (int col = 0; col < COUNT_COL_SUB_TABLE; col++) {
        SudokuSubTable subTable =
            SudokuSubTable(indexRowInTable: row, indexColInTable: col);
        subTable.init();
        list.add(subTable);
      }
      table.add(list);
    }
  }
}

class _Sudoku extends State<Sudoku> {
  /// Theme game
  ///
  Color colorBorderTable = Color(0xff1f5c71);
  Color colorBackgroundApp = Color(0xff1f5c71);
  Color colorBackgroundChannelEmpty1 = Color(0xffe3e3e3);
  Color colorBackgroundChannelEmpty2 = Colors.white30;
  Color colorBackgroundNumberTab = Colors.white;
  Color colorTextNumber = Colors.white;
  Color colorBackgroundChannelValue = Color(0xff6ea4bf);
  Color colorBackgroundChannelValueFixed = Color(0xff503156);

  SudokuTable sudokuTable;
  bool conflictMode = false;
  double channelSize = 0;
  double fontScale = 1;

  @override
  void initState() {
    initSudokuTable();
    initTableFixed();
    super.initState();
  }

  void initSudokuTable() {
    sudokuTable = SudokuTable();
    sudokuTable.init();
  }

  void initTableFixed() {
    SudokuSubTable subTableLeftTop = sudokuTable.table[0][0];
    subTableLeftTop.setValue(row: 0, col: 2, value: 5, enableMove: false);
    subTableLeftTop.setValue(row: 1, col: 0, value: 1, enableMove: false);
    subTableLeftTop.setValue(row: 1, col: 2, value: 2, enableMove: false);

    SudokuSubTable subTableTop = sudokuTable.table[0][1];
    subTableTop.setValue(row: 0, col: 0, value: 9, enableMove: false);
    subTableTop.setValue(row: 1, col: 1, value: 6, enableMove: false);
    subTableTop.setValue(row: 1, col: 2, value: 8, enableMove: false);
    subTableTop.setValue(row: 2, col: 0, value: 2, enableMove: false);

    SudokuSubTable subTableRightTop = sudokuTable.table[0][2];
    subTableRightTop.setValue(row: 0, col: 1, value: 1, enableMove: false);
    subTableRightTop.setValue(row: 1, col: 0, value: 4, enableMove: false);
    subTableRightTop.setValue(row: 2, col: 0, value: 7, enableMove: false);

    SudokuSubTable subTableLeft = sudokuTable.table[1][0];
    subTableLeft.setValue(row: 0, col: 0, value: 2, enableMove: false);
    subTableLeft.setValue(row: 0, col: 1, value: 1, enableMove: false);
    subTableLeft.setValue(row: 1, col: 1, value: 4, enableMove: false);
    subTableLeft.setValue(row: 1, col: 2, value: 8, enableMove: false);
    subTableLeft.setValue(row: 2, col: 1, value: 5, enableMove: false);

    SudokuSubTable subTableCenter = sudokuTable.table[1][1];
    subTableCenter.setValue(row: 0, col: 0, value: 8, enableMove: false);
    subTableCenter.setValue(row: 0, col: 2, value: 6, enableMove: false);
    subTableCenter.setValue(row: 1, col: 1, value: 9, enableMove: false);
    subTableCenter.setValue(row: 2, col: 0, value: 4, enableMove: false);
    subTableCenter.setValue(row: 2, col: 2, value: 3, enableMove: false);

    SudokuSubTable subTableRight = sudokuTable.table[1][2];
    subTableRight.setValue(row: 0, col: 1, value: 3, enableMove: false);
    subTableRight.setValue(row: 1, col: 0, value: 6, enableMove: false);
    subTableRight.setValue(row: 1, col: 1, value: 5, enableMove: false);
    subTableRight.setValue(row: 2, col: 1, value: 7, enableMove: false);
    subTableRight.setValue(row: 2, col: 2, value: 8, enableMove: false);

    SudokuSubTable subTableBottomLeft = sudokuTable.table[2][0];
    subTableBottomLeft.setValue(row: 0, col: 2, value: 4, enableMove: false);
    subTableBottomLeft.setValue(row: 1, col: 2, value: 3, enableMove: false);
    subTableBottomLeft.setValue(row: 2, col: 1, value: 6, enableMove: false);

    SudokuSubTable subTableBottom = sudokuTable.table[2][1];
    subTableBottom.setValue(row: 0, col: 2, value: 2, enableMove: false);
    subTableBottom.setValue(row: 1, col: 0, value: 6, enableMove: false);
    subTableBottom.setValue(row: 1, col: 1, value: 8, enableMove: false);
    subTableBottom.setValue(row: 2, col: 2, value: 4, enableMove: false);

    SudokuSubTable subTableBottomRight = sudokuTable.table[2][2];
    subTableBottomRight.setValue(row: 1, col: 0, value: 5, enableMove: false);
    subTableBottomRight.setValue(row: 1, col: 2, value: 1, enableMove: false);
    subTableBottomRight.setValue(row: 2, col: 0, value: 3, enableMove: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double shortestSize = size.shortestSide;
    double width = size.width;
    double height = size.height;

    // Tablet case
    if (shortestSize >= 600) {
      fontScale = 1.7;
      if (width > height) {
        // Tablet landscape
        channelSize = shortestSize / 9 - 30;
      } else {
        // tablet portrait
        channelSize = shortestSize / 9 - 10;
      }
    } else {
      // phone case (portrait only)
      channelSize = shortestSize / 9 - 10;
    }

    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            color: Color(0xff1f5c71),
            child: Column(children: <Widget>[
              buildMenu(),
              Expanded(
                  child: Container(
                      constraints: BoxConstraints.expand(),
                      child: Center(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: colorBorderTable,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              padding: EdgeInsets.all(6),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        buildSubTable(sudokuTable.table[0][0],
                                            colorBackgroundChannelEmpty1),
                                        buildSubTable(sudokuTable.table[0][1],
                                            colorBackgroundChannelEmpty2),
                                        buildSubTable(sudokuTable.table[0][2],
                                            colorBackgroundChannelEmpty1),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        buildSubTable(sudokuTable.table[1][0],
                                            colorBackgroundChannelEmpty2),
                                        buildSubTable(sudokuTable.table[1][1],
                                            colorBackgroundChannelEmpty1),
                                        buildSubTable(sudokuTable.table[1][2],
                                            colorBackgroundChannelEmpty2),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        buildSubTable(sudokuTable.table[2][0],
                                            colorBackgroundChannelEmpty1),
                                        buildSubTable(sudokuTable.table[2][1],
                                            colorBackgroundChannelEmpty2),
                                        buildSubTable(sudokuTable.table[2][2],
                                            colorBackgroundChannelEmpty1),
                                      ],
                                    )
                                  ]),
                            )
                          ])))),
              Container(
                  padding: EdgeInsets.all(16),
                  color: colorBackgroundNumberTab,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildNumberListTab())),
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
                  restart();
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
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()))),
            ])));
  }

  Container buildMenu() {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 8, right: 16, left: 16),
      constraints: BoxConstraints.expand(height: 100),
      color: Color(0xffffffff),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        SizedBox(
          width: 100,
        ),
        Text("SUDOKU",
            style: TextStyle(
                color: Colors.blue[700],
                fontFamily: 'hs_us',
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        SizedBox(
          width: 62,
        ),
        FlatButton(
          child: Image.asset(
            "assets/images/info.png",
            height: 40,
            width: 40,
          ),
          onPressed: () {
            customDialog(context);
          },
        ),
      ]),
    );
  }

  Container buildSubTable(SudokuSubTable subTable, Color color) {
    return Container(
        padding: EdgeInsets.all(2),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildRowChannel(subTable, 0, color)),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildRowChannel(subTable, 1, color)),
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildRowChannel(subTable, 2, color))
        ]));
  }

  List<Widget> buildRowChannel(
      SudokuSubTable subTable, int rowChannel, Color color) {
    List<SudokuChannel> dataRowChanel = subTable.subTable[rowChannel];
    List<Widget> listWidget = List();
    for (int col = 0; col < 3; col++) {
      Widget widget = buildChannel(rowChannel, dataRowChanel[col], color,
          onNumberAccept: (data) {
        setState(() {
          sudokuTable.table[subTable.indexRowInTable][subTable.indexColInTable]
              .subTable[rowChannel][col] = SudokuChannel(value: data);
        });
      }, onRemove: () {
        setState(() {
          sudokuTable.table[subTable.indexRowInTable][subTable.indexColInTable]
              .subTable[rowChannel][col] = SudokuChannel();
        });
      }, onHover: (value) {
        setState(() {
          showWaringConflictChannel(subTable.indexRowInTable,
              subTable.indexColInTable, rowChannel, col, value);
        });
      }, onHoverEnd: () {
        clearWaringConflictChannel();
      });
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildChannel(int rowChannel, SudokuChannel channel, Color color,
      {Function(int) onNumberAccept,
      Function() onRemove,
      Function(int) onHover,
      Function onHoverEnd}) {
    if (channel.value == 0) {
      return DragTarget(builder: (BuildContext context, List<int> candidateData,
          List<dynamic> rejectedData) {
        print("candidateData = " + candidateData.toString());
        return buildChannelEmpty();
      }, onWillAccept: (data) {
        bool accept = data >= 0 && data <= 9;
        if (accept) {
          if (!conflictMode) {
            onHover(data);
          }
        }

        return accept;
      }, onAccept: (data) {
        onNumberAccept(data);
        onHoverEnd();
      }, onLeave: (data) {
        onHoverEnd();
      });
    } else {
      if (channel.enableMove) {
        return DragTarget(builder: (BuildContext context,
            List<int> candidateData, List<dynamic> rejectedData) {
          return Draggable(
            child: buildChannelValue(channel),
            feedback: Material(
                type: MaterialType.transparency,
                child: buildChannelValue(channel)),
            childWhenDragging: buildChannelEmpty(),
            onDragCompleted: () {
              onRemove();
            },
            onDraggableCanceled: (v, o) {
              onRemove();
            },
            data: channel.value,
          );
        }, onWillAccept: (data) {
          return data >= 0 && data <= 9;
        }, onAccept: (data) {
          onNumberAccept(data);
        });
      } else {
        return buildChannelValueFixed(channel);
      }
    }
  }

  Container buildChannelEmpty() {
    return Container(
      margin: EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: colorBackgroundChannelEmpty1,
          borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }

  Widget buildChannelValue(SudokuChannel channel) {
    return Container(
      margin: EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: getColorIfWarning(channel, colorBackgroundChannelValue),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Center(
          child: Text(channel.value.toString(),
              textScaleFactor: fontScale,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'hs_us',
                  fontSize: 20,
                  fontWeight: FontWeight.w900))),
    );
  }

  Color getColorIfWarning(SudokuChannel channel, Color colorDefault) {
    if (channel.enableWarning) {
      return Color(0xffe04251);
    }
    return colorDefault;
  }

  Widget buildChannelValueFixed(SudokuChannel channel) {
    return Container(
      margin: EdgeInsets.all(1),
      width: channelSize,
      height: channelSize,
      decoration: BoxDecoration(
          color: getColorIfWarning(channel, colorBackgroundChannelValueFixed),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Center(
          child: Text(channel.value.toString(),
              textScaleFactor: fontScale,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'hs_us',
                  fontWeight: FontWeight.w900))),
    );
  }

  List<Widget> buildNumberListTab() {
    List<Widget> listWidget = List();
    for (int i = 1; i <= 9; i++) {
      Widget widget = buildNumberBoxWithDraggable(i);
      listWidget.add(widget);
    }
    return listWidget;
  }

  Widget buildNumberBoxWithDraggable(int i) {
    return Draggable(
      child: buildNumberBox(i),
      feedback:
          Material(type: MaterialType.transparency, child: buildNumberBox(i)),
      data: i,
      onDragEnd: (d) {
        setState(() {
          clearWaringConflictChannel();
        });
      },
    );
  }

  Container buildNumberBox(int i) {
    return Container(
        width: channelSize,
        height: channelSize,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            color: colorBackgroundChannelValue,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text("$i",
                textScaleFactor: fontScale,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'hs_us',
                    color: colorTextNumber,
                    fontWeight: FontWeight.w900))));
  }

  void showWaringConflictChannel(int rowSubTable, int colSubTable,
      int rowChannel, int colChannel, int value) {
    // Check horizontal
    for (int i = 0; i < COUNT_ROW_SUB_TABLE; i++) {
      for (int j = 0; j < COUNT_ROW_SUB_TABLE; j++) {
        SudokuChannel channel =
            sudokuTable.table[rowSubTable][i].subTable[rowChannel][j];
        sudokuTable.table[rowSubTable][i].subTable[rowChannel][j]
            .enableWarning = channel.value == value;
        print("" + channel.value.toString());
      }
    }

    // Check vertical
    for (int i = 0; i < COUNT_COL_SUB_TABLE; i++) {
      for (int j = 0; j < COUNT_COL_SUB_TABLE; j++) {
        SudokuChannel channel =
            sudokuTable.table[i][colSubTable].subTable[j][colChannel];
        sudokuTable.table[i][colSubTable].subTable[j][colChannel]
            .enableWarning = channel.value == value;
        print("" + channel.value.toString());
      }
    }

    conflictMode = true;
  }

  void clearWaringConflictChannel() {
    // Check horizontal

    for (int i = 0; i < COUNT_ROW_SUB_TABLE; i++) {
      for (int j = 0; j < COUNT_ROW_SUB_TABLE; j++) {
        for (int k = 0; k < COUNT_ROW_SUB_TABLE; k++) {
          for (int m = 0; m < COUNT_ROW_SUB_TABLE; m++) {
            sudokuTable.table[i][j].subTable[k][m].enableWarning = false;
          }
        }
      }
    }

    conflictMode = false;
  }

  void restart() {
    setState(() {
      initSudokuTable();
      initTableFixed();
    });
  }

  customDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.20,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Color(0xff0355e8),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Rule 1: Know the Game First:  ",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Color(0xffebe9d8),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Sudoku is a 9 by 9 puzzles that contain nine 3 by 3 regions. Every region, column, and row also contains nine cells. This game is more like a puzzle game. If you want to play it there is no need for you to make mathematical calculations. In fact, you can just use simple logic in order to get the solution that you want for the game. That is why it is very important that you familiarize yourself with the game. At first, it can be really difficult to play the game. But then eventually, you can play the game really well.",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xff0355e8),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Rule 2: Use digits from 1 – 9:  ",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Color(0xffebe9d8),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "The basic essence of the game is for you to fill the 9 by 9 grid with numerical digits. Each row, column and the 3 by 3 grids should contain digits from numbers 1 to 9. This game is quite easy to play especially for those people who have been playing Sudoku for a long period of time.",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xff0355e8),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Rule 3: Avoid repetition of figures",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Color(0xffebe9d8),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Another rule you need to adhere to is to avoid using numbers that already exist in the same region, column or row. In other words, if a number is already occupying a position, ensure it doesn’t appear on the same place within the same column, row or region.Here is an example. If the number 3 already appears in the same position in a region, row or column, then the number 3 can only appear in a different position. That’s how Sudoku works.",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xff0355e8),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Rule 4: Avoid guesswork      ",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'hs_us',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Color(0xffebe9d8),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Well, this is not entirely a rule per se. It is just a piece of advice that will help you tackle this puzzle game with ease. Sudoku is a game that attempts to test the mental capacity of a player. It also encourages and requires patience and maximum concentration from a player. Sudoku is also not a game of math because it involves the use of numbers. All you need is to do is engage in some logical reasoning to identify the missing givens and put them in the right cells.",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xff0355e8),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Rule 5: Use the elimination method",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Color(0xffebe9d8),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "This rule is quite simple: eliminate or note down any number that appears in the same row, column or region. In this case, you have to check each square properly (horizontally and vertically) and take note of the numbers that appeared and the position they are occupying. Remember that one of the rules states that there should be no duplication or repetition of numbers. In other words, you cannot have the same number written on the same position on the grid horizontally or vertically when you trace from top to bottom.",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xff0355e8),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Rule 6: Read Various Sudoku Techniques Online",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      color: Color(0xffebe9d8),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "If you want to make things easier, you can find some tips online. Many players would post information regarding the different techniques in playing Sudoku. Using the Internet, you can find information about how to play Sudoku or see the video above. You can just use this set of information and details to know how the game goes. There are different combinations that can come out. But if you know different techniques then you will not have a hard time solving the puzzle.",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'hs_us',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
