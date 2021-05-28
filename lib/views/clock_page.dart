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
    var formattedTime = DateFormat('HH:mm').format(now);
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
                color: Colors.white, 
                fontWeight: FontWeight.w700,
                fontFamily: 'avenir',
                fontSize: 24
              )
            )
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(
                  formattedTime, 
                  style: TextStyle(
                    color: Colors.white, 
                    fontFamily: 'avenir',
                    fontSize: 64
                  )
                ),
                Text(
                  formattedDate, 
                  style: TextStyle(
                    color: Colors.white, 
                    fontFamily: 'avenir',
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
                    color: Colors.white, 
                    fontFamily: 'avenir',
                    fontSize: 20
                  )
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.language, 
                      color: Colors.white
                    ),
                    SizedBox(
                      width: 16
                    ),
                    Text(
                      'UTC' + offsetSign + timeZoneString, 
                      style: TextStyle(
                        color: Colors.white, 
                        fontFamily: 'avenir',
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