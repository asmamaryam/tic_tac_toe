// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import '../constants/colors.dart';
import '../widget/timer.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String resultdeclation = '';
  bool Oturn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> colorChange = [];

  int oScore = 0;
  int xScore = 0;
  int filledBox = 0;
  bool winnerfound = false;

  static const maxsecods = 30;
  int seconds = maxsecods;
  Timer? timer;

  static var customFontWhite = GoogleFonts.coiny(
      textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 30,
    letterSpacing: 3,
  ));

  void _startITmer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    _reset();
    timer?.cancel();
  }

  void _reset() {
    seconds = maxsecods;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Player O',
                          style: customFontWhite,
                        ),
                        Text(
                          oScore.toString(),
                          style: customFontWhite,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // for X
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Player X',
                          style: customFontWhite,
                        ),
                        Text(
                          xScore.toString(),
                          style: customFontWhite,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: GridView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: MainColor.primaryColor,
                            width: 3,
                          ),
                          color: colorChange.contains(index)
                              ? MainColor.accentcolor
                              : MainColor.secondarycolor,
                        ),
                        child: Center(
                            child: Text(displayXO[index],
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    fontSize: 50,
                                    color: MainColor.primaryColor,
                                  ),
                                ))),
                      ),
                    );
                  },
                )),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        resultdeclation,
                        style: customFontWhite,
                      ),
                      TimerWidget(
                        startITmer: _startITmer,
                        clear: _clear,
                        seconds: seconds,
                        maxseconds: maxsecods,
                        isRunning: timer == null ? false : timer!.isActive,
                      )
                    ]),
              ),
            ),
          ],
        ));
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (Oturn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBox++;
        } else if (!Oturn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBox++;
        }
        Oturn = !Oturn;
        _checkWinner();
      });
    }
  }

  //  for winner using index
  void _checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultdeclation = 'Player ' + displayXO[0] + ' Wins!';
        colorChange.addAll([0, 1, 2]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }

    ////
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultdeclation = 'Player ' + displayXO[3] + ' Wins!';
        colorChange.addAll([3, 4, 5]);
        _stopTimer();
        _updateScore(displayXO[3]);
      });
    }
    ////
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultdeclation = 'Player ' + displayXO[6] + ' Wins!';
        colorChange.addAll([6, 7, 8]);
        _stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    //// colums /////

    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultdeclation = 'Player ' + displayXO[0] + ' Wins!';
        colorChange.addAll([0, 3, 6]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    ////
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultdeclation = 'Player ' + displayXO[1] + ' Wins!';
        colorChange.addAll([1, 4, 7]);
        _stopTimer();
        _updateScore(displayXO[1]);
      });
    }
    ////
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultdeclation = 'Player ' + displayXO[2] + ' Wins!';
        colorChange.addAll([2, 5, 8]);
        _stopTimer();
        _updateScore(displayXO[2]);
      });
    }
    ////   check diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultdeclation = 'Player ' + displayXO[0] + ' Wins!';
        colorChange.addAll([0, 4, 8]);
        _stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    ////
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultdeclation = 'Player ' + displayXO[6] + ' Wins!';
        colorChange.addAll([6, 4, 2]);
        _stopTimer();

        _updateScore(displayXO[6]);
      });
    }
    if (!winnerfound && filledBox == 9) {
      setState(() {
        resultdeclation = 'Nobody Wins';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerfound = true;
  }

  void _clear() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        // to clear the board
        displayXO[i] = '';
      }
      resultdeclation = '';
      filledBox = 0;
    });
  }
}
