// @dart=2.9

import 'package:alarm_clock/alarm_helper.dart';
import 'package:alarm_clock/constants/theme_data.dart';
import 'package:alarm_clock/data.dart';
import 'package:alarm_clock/models/alarm_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'package:sqflite/sqflite.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  // idk
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;

// idk
  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

// idk
  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical:64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Alarm',
            style: TextStyle(
              fontFamily: 'work',
              fontWeight: FontWeight.w700,
              color: CustomColors.primaryTextColor,
              fontSize: 24
            )
          ),
          Expanded( 
            //insert future builder widget idk how
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                _currentAlarms = snapshot.data;
                return ListView(
                  children: snapshot.data.map<Widget>((alarm) {
                    var alarmTime = DateFormat('hh:mm aa').format(alarm.alarmDateTime);
                    var gradientColor = GradientTemplate.gradientTemplate[alarm.gradientColorIndex].colors;
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.colorDodge ,
                    gradient: LinearGradient(
                      colors: gradientColor,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColor.last.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(4, 4)
                      )]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.label,
                                color: CustomColors.primaryTextColor,
                                size: 24
                              ),
                              SizedBox(width: 8),
                              Text(
                                alarm.title, 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'work',
                                )
                              )
                            ]
                          ),
                          Switch(
                            onChanged: (bool value) {},
                            value: true,
                            activeColor: CustomColors.primaryTextColor
                          )
                        ]
                      ),
                      Text(
                        DateFormat('EEEE').format(DateTime.now()),
                        style: TextStyle(
                          color: CustomColors.primaryTextColor,
                          fontFamily: 'work',
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            alarmTime, 
                            style: TextStyle(
                              color: CustomColors.primaryTextColor,
                              fontSize: 24,
                              fontFamily: 'work',
                              fontWeight: FontWeight.w700
                            )
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: CustomColors.primaryTextColor,
                            onPressed: () {
                              deleteAlarm(alarm.id);
                            },
                          )
                        ],
                      )
                    ]
                  )
                );
              }).followedBy([
                if (_currentAlarms.length < 5)
                DottedBorder(
                  strokeWidth: 3,
                  color: CustomColors.clockOutline,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24),
                  dashPattern: [3 , 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.clockBG,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                    
                    child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                          onPressed: () {
                                _alarmTimeString =
                                    DateFormat('HH:mm').format(DateTime.now());
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setModalState) {
                                        return Container(
                                          padding: const EdgeInsets.all(32),
                                          child: Column(
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  var selectedTime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  );
                                                  if (selectedTime != null) {
                                                    final now = DateTime.now();
                                                    var selectedDateTime =
                                                        DateTime(
                                                            now.year,
                                                            now.month,
                                                            now.day,
                                                            selectedTime.hour,
                                                            selectedTime
                                                                .minute);
                                                    _alarmTime = selectedDateTime;
                                                    setModalState(() {
                                                      _alarmTimeString =DateFormat('HH:mm').format(selectedDateTime);
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  _alarmTimeString,
                                                  style:
                                                      TextStyle(fontSize: 32),
                                                ),
                                              ),
                                              // repeat alarm button
                                              ListTile(
                                                title: Text('Repeat'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              // customize sound button
                                              ListTile(
                                                title: Text('Sound'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              // add titile
                                              ListTile(
                                                title: Text('Title'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              FloatingActionButton.extended(
                                                onPressed: onSaveAlarm,
                                                icon: Icon(Icons.alarm),
                                                label: Text('Save'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                                // scheduleAlarm();
                          },
                          child: Column(
                        children: <Widget>[
                          Image.asset('assets/Bells.png', 
                          fit: BoxFit.contain,
                          height: 40,
                          width: 40,
                          scale: 1.5),
                          
                          SizedBox(height: 8),
                          Text(
                            'add alarm',
                            style:  TextStyle(
                              color: CustomColors.primaryTextColor,
                              fontFamily: 'work')
                          )
                        ]
                      )
                    )
                  ),
                )
                else
                  Center(
                    child: Text(
                      'Only 5 alarms allowed',
                      style: TextStyle(color: Colors.white)
                  ))
              ]).toList(),
            );
            }
            return Center(
              child: Text(
                'Loading',
                style: TextStyle(
                  color: CustomColors.primaryTextColor)
                ),
              );
              },
            )
          )
        ]
      )
    );
  }

  void scheduleAlarm(
    DateTime scheduleNotificationDateTime, AlarmInfo alarmInfo) async {
    // var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 10));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm Notification',
      importance: Importance.max,
      visibility: NotificationVisibility.public,
      priority: Priority.high,
      icon: 'berrycake',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('berrycake')
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.schedule(0, 'Office', alarmInfo.title,
        scheduleNotificationDateTime, platformChannelSpecifics);
    }
// more stuff idk
  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms(); 
  }
}