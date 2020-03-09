import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/modules/info/screens/basic_protetive_measure.dart';
import 'package:corona_app/src/modules/info/screens/faq_page.dart';
import 'package:corona_app/src/modules/info/screens/myths_page.dart';
import 'package:corona_app/src/modules/main/screens/main_screen.dart';
import 'package:corona_app/src/modules/numbers/screens/numbers_page.dart';
import 'package:corona_app/src/modules/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
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
        });
  }
}
