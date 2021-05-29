// @dart=2.9

import 'dart:async';
import 'package:alarm_clock/constants/theme_data.dart';
import 'package:alarm_clock/views/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override

  Widget build(BuildContext context) {
    var now = DateTime.now();
    
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timeZoneString.startsWith('-')) offsetSign = '+';
    print(timeZoneString);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32, 
        vertical: 64
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              'Clock', 
              style: TextStyle(
                color: CustomColors.primaryTextColor, 
                fontWeight: FontWeight.w700,
                fontFamily: 'work',
                fontSize: 24
              )
            )
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                DigitalClockWidget(),
                Text(
                  formattedDate, 
                  style: TextStyle(
                    color: CustomColors.primaryTextColor, 
                    fontFamily: 'work',
                    fontSize: 20
                  )
                )
              ]
            )
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.center,
              child: ClockView(
                size: MediaQuery.of(context).size.height / 4)
            )
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(
                  'Timezone', 
                  style: TextStyle(
                    color: CustomColors.primaryTextColor,
                    fontFamily: 'work',
                    fontSize: 20
                  )
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.language, 
                      color: CustomColors.primaryTextColor,
                    ),
                    SizedBox(
                      width: 16
                    ),
                    Text(
                      'UTC' + offsetSign + timeZoneString, 
                      style: TextStyle(
                        color: CustomColors.primaryTextColor,
                        fontFamily: 'work',
                        fontSize: 14
                      )
                    )
                  ]
                )
              ]
            )
          )
        ]
      )
      );
  }
}

class DigitalClockWidget extends StatefulWidget {
    const DigitalClockWidget({
    Key key,
  }) : super(key :  key);

  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now()); 
  @override 
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      var previousMinute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (previousMinute != currentMinute) {
      setState(() {
        formattedTime = DateFormat('HH:mm').format(DateTime.now());
      });
    }});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: TextStyle(
        fontFamily: 'work',
        color: CustomColors.primaryTextColor,
        fontSize: 64
      )
    );
  }
}