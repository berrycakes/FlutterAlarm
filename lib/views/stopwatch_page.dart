import 'package:alarm_clock/constants/theme_data.dart';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Stopwatch here', style: TextStyle(
        fontFamily: 'avenir',
        fontSize: 50,
        color: CustomColors.primaryTextColor
      )
      ) 
    );
  }
}