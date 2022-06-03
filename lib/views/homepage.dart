// @dart=2.9

import 'package:alarm_clock/constants/theme_data.dart';
import 'package:alarm_clock/data.dart';
import 'package:alarm_clock/enums.dart';
import 'package:alarm_clock/models/menu_info.dart';
import 'package:alarm_clock/views/clock_page.dart';
import 'package:alarm_clock/views/alarm_page.dart';
import 'package:alarm_clock/views/stopwatch_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/animation.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((currentMenuInfo) => buildMenuButton(currentMenuInfo)).toList()
          ),
          VerticalDivider(
            color: CustomColors.dividerColor, 
            width: 1
          ),
          Expanded(
            child: Consumer<MenuInfo> (
              builder: (BuildContext context, MenuInfo value, Widget child) {
                
                if(value.menuType == MenuType.clock) return ClockPage();
                else if(value.menuType == MenuType.alarm) return AlarmPage();
                else if(value.menuType ==MenuType.stopwatch) return LogoApp();
                else  return Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical:64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        value.title,
                        style: TextStyle(
                          fontFamily: 'work',
                          fontWeight: FontWeight.w700,
                          color: CustomColors.primaryTextColor,
                          fontSize: 24
                      )
                    ),
                    SizedBox(height: 200),
                    Image.asset('assets/Sleep.png',
                    scale: 1.5,
                    fit: BoxFit.contain,
                    height: 100.0,
                    width: 100.0),
                    Text('Coming Soon!',
                      style: TextStyle(
                      fontFamily: 'work', 
                      color: CustomColors.primaryTextColor,
                      fontSize: 14)
                    )
                  ]));
              }
            )
          )
        ]
      )
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(32))
          ),
          backgroundColor: 
          currentMenuInfo.menuType == value.menuType 
          ? CustomColors.menuBackgroundColor
          : Colors.transparent),
          onPressed:  () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          }, 
          child: Column(
            children: <Widget> [
              Image.asset(
                currentMenuInfo.imageSource, 
                scale: 1.5,
                fit: BoxFit.contain,
                height: 50.0,
                width: 50.0,
                ),
              SizedBox(height: 16),
              Text(
                currentMenuInfo.title ?? '', style: TextStyle(
                  fontFamily: 'work', 
                  color: CustomColors.primaryTextColor,
                  fontSize: 14
                )
              )
            ] 
          )
        );
      }
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}