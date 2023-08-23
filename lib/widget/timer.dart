// ignore_for_file: must_be_immutable, override_on_non_overriding_member

import 'package:flutter/material.dart';
// import 'dart:async';

import '../constants/colors.dart';

class TimerWidget extends StatefulWidget {
  final Function startITmer;

  final Function clear;
  final int seconds;
  final int maxseconds;
  final bool isRunning;

  TimerWidget({
    required this.startITmer,
    required this.clear,
    required this.seconds,
    required this.maxseconds,
    required this.isRunning,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  int attempt = 0;
  Widget build(BuildContext context) {
    //  final  isRunning = timer == null ? false : timer!.isActive;

    return widget.isRunning
        ? SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - widget.seconds / widget.maxseconds,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  backgroundColor: MainColor.accentcolor,
                  strokeWidth: 4,
                ),
                Center(
                  child: Text(
                    '${widget.seconds}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              widget.startITmer();
              widget.clear();
              attempt++;
            },
            child: Text(
              attempt == 0 ? 'Start' : 'Play Again',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          );
  }
}
