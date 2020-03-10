import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/modules/info/screens/basic_protetive_measure.dart';
import 'package:corona_app/src/modules/info/screens/faq_page.dart';
import 'package:corona_app/src/modules/info/screens/myths_page.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  static final routeName = "./info";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Info",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.all(32),
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  getMenuItem(context, "Frequently Asked Questions", "faq"),
                  getMenuItem(context, "Basic Protective Measures", "bpm"),
                  getMenuItem(context, "Myths", "myths"),
                 // getMenuItem(context, "Notify Me", "notify"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getMenuItem(BuildContext context, String menu, String type) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: InkWell(
          onTap: () {
            switch (type) {
              case "faq":
                Navigator.pushNamed(context, FAQPage.routeName);
                break;
              case "bpm":
                Navigator.pushNamed(context, BasicProtectiveMeasure.routeName);
                break;
              case "myths":
                Navigator.pushNamed(context, MythsPage.routeName);
                break;
            }
          },
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xff2D4361),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Text(
              menu,
              style: TextStyle(
                  fontFamily: CustomAppTheme.fontName,
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
