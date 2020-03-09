import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/disclaimer_page.dart';
import 'package:corona_app/src/core/widgets/network_error_widget.dart';
import 'package:corona_app/src/modules/info/screens/basic_protetive_measure.dart';
import 'package:corona_app/src/modules/info/screens/faq_page.dart';
import 'package:corona_app/src/modules/info/screens/myths_page.dart';
import 'package:corona_app/src/modules/main/screens/main_screen.dart';
import 'package:corona_app/src/modules/numbers/screens/numbers_page.dart';
import 'package:corona_app/src/modules/splash/screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (message != null) {
          showNotification(message['notification']['title'],
              message['notification']['body']);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: CustomAppTheme.primaryColor,
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
        title: 'Covid Now',
        theme: ThemeData(
          primaryColor: CustomAppTheme.primaryColor,
          accentColor: CustomAppTheme.accentColor,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: CustomAppTheme.primaryColor,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder()
          }),
        ),
        home: SplashScreen(),
        routes: {
          NumbersPage.routeName: (ctx) => NumbersPage(),
          MainScreen.routeName: (ctx) => MainScreen(),
          FAQPage.routeName: (ctx) => FAQPage(),
          BasicProtectiveMeasure.routeName: (ctx) => BasicProtectiveMeasure(),
          MythsPage.routeName: (ctx) => MythsPage(),
          ConnectionScreen.routeName: (ctx) => ConnectionScreen(),
          DisclaimerPage.routeName: (ctx) => DisclaimerPage(),
        });
  }

  showNotification(String title, String body) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'covid.now', 'Covid', 'Covid-Now',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(99, "$title", "$body", platformChannelSpecifics, payload: "");
  }

  Future onSelectNotification(String payload) async {
    Navigator.pushNamed(context, MainScreen.routeName);
  }

  Future<dynamic> onDidReceiveLocalNotification(
      int n, String s1, String s2, String payload) async {}
}
