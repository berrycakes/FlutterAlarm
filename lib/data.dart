// @dart=2.9

import 'package:alarm_clock/enums.dart';
import 'models/alarm_info.dart';
import 'models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Home', imageSource: 'assets/Home.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/Alarm.png'),
  MenuInfo(MenuType.timer,
      title: 'Timer', imageSource: 'assets/Pomodoro.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imageSource: 'assets/Clock.png'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Office',
      gradientColorIndex: 0),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Sport',
      gradientColorIndex: 1),
];