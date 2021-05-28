import 'package:alarm_clock/constants/theme_data.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Timer here', style: TextStyle(
        fontFamily: 'avenir',
        fontSize: 50,
        color: CustomColors.primaryTextColor
      )
      ),
    );
  }
}