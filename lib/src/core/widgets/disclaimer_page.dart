import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:flutter/material.dart';

class DisclaimerPage extends StatelessWidget {
  static final routeName = "./disclaimer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              "Disclaimer",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  fontFamily: CustomAppTheme.secFontName),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          color: Colors.transparent,
          height: 400,
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.only(top: 5, bottom: 15),
          alignment: Alignment.centerLeft,
          child: Text(
            "The app and all its content are provided for educational and academic research purposes. All the data present in the app is taken from multiple sources which are publicly available. These sources not always agree with each other and can have errors/wrong data points." +
                "\n \nOneNight Developers hereby disclaims any and all representation and waranties with respect to the app, including accuracy, fitness for use and merchanability. Reliance of the app for medical purpose is strictly prohibited.",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: CustomAppTheme.fontName),
          ),
        ),
      ),
    );
  }
}
