import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/bottom_nav_bar.dart' as bmnav;
import 'package:corona_app/src/modules/info/screens/info_page.dart';
import 'package:corona_app/src/modules/numbers/screens/map_page.dart';
import 'package:corona_app/src/modules/numbers/screens/numbers_page.dart';
import 'package:corona_app/src/modules/numbers/screens/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  static final routeName = "./main/screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;
  final List<Widget> _children = [
    NumbersPage(),
    StatsPage(),
    MapSample(key: UniqueKey()),
    InfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: CustomAppTheme.primaryColor,
        systemNavigationBarColor: CustomAppTheme.primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light));

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bmnav.BottomNav(
          color: CustomAppTheme.primaryColor,
          iconStyle: bmnav.IconStyle(
              color: Colors.white,
              onSelectColor: CustomAppTheme.accentColor,
              size: 20,
              onSelectSize: 25),
          labelStyle: bmnav.LabelStyle(
              textStyle: TextStyle(
                color: Colors.white,
                fontFamily: CustomAppTheme.fontName,
              ),
              onSelectTextStyle: TextStyle(
                color: CustomAppTheme.accentColor,
                fontFamily: CustomAppTheme.fontName,
              )),
          elevation: 15,
          index: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          // this will be set when a new tab is tapped
          items: [
            bmnav.BottomNavItem(Icons.offline_bolt, label: 'Overview'),
            bmnav.BottomNavItem(Icons.graphic_eq, label: 'Stats'),
            bmnav.BottomNavItem(Icons.map, label: 'Map'),
            bmnav.BottomNavItem(Icons.more, label: 'More')
          ],
        ),
        body: _children[_currentIndex],
      ),
    );
  }
}
