// @dart=2.9

import 'package:alarm_clock/enums.dart';
import 'package:alarm_clock/views/homepage.dart';
import 'package:alarm_clock/models/menu_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/animation.dart';
import 'package:page_transition/page_transition.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
    // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  //i dunno where this came from maybe for permissions
  var initializationSettingsAndroid = AndroidInitializationSettings('berrycake');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: 
    (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String payload) async {
      if(payload != null) {
        debugPrint('notification payload: ' + payload);
      }
    },
  );
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'berrycake',
        home: AnimatedSplashScreen(
          backgroundColor: Colors.blue[50],
          animationDuration: Duration(seconds: 3),
          splashTransition: SplashTransition.scaleTransition,
          curve: Curves.elasticOut,
          splashIconSize: double.infinity,
          splash: Container(
            alignment: Alignment.center,
            child: Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/berrycake.png',
                  fit: BoxFit.contain, 
                    height: 200,
                    width: 200
                    ),
                  // Text('berrycake',
                  //   style: TextStyle(
                  //     fontFamily: 'work',
                  //     fontSize: 16,
                  //     color: CustomColors.primaryTextColor
                  //   )
                  // )
                ],),
            ),
          ),
          duration: 500,
          pageTransitionType: PageTransitionType.rotate,
          nextScreen: MainScreen(),
        )
    );
  }
}

class MainScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock),
        child: 
        Homepage() 
      ),
    );
  }
}
