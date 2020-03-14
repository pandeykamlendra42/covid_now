import 'package:flutter/material.dart';

class CustomAppTheme {
  CustomAppTheme._();

  static double screenHeight = 0;
  static double screenWidth = 0;
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color primaryColor = const Color(0xFF142342);
  static const Color accentColor = const Color(0xff41B7C7);
  static const Color themeRedColor = const Color(0xFFC82424);
  static const Color themeGreenColor = const Color(0xffB7F86D);
  static const Color themeYellowColor = const Color(0xffd68709);

  static const Color googleThemeColor = Color(0xFFDE5246);
  static const Color facebookThemeColor = Color(0xFF4169A7);
  static const Color landingBackgroundColor = Color(0xFFE8F8FF);
  static const Color loginTextColor = Color(0xFF1393CB);

  static const Color darkTextColor = Color(0xFF253840);
  static const Color darkerTextColor = Color(0xFF17262A);
  static const Color lightTextColor = Color(0xFFA6A6A6);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Comfortaa';
  static const String secFontName = 'Futura';

  static TextStyle display1 = TextStyle(
      color: darkerTextColor,
      fontSize: CustomAppTheme.screenHeight * 1 / 20,
      fontWeight: FontWeight.w400);

  static TextStyle signupFieldText = TextStyle(
      color: darkTextColor,
      fontSize: CustomAppTheme.screenHeight * 1 / 28,
      fontWeight: FontWeight.w400);

  static TextStyle signupHintStyle = TextStyle(
      color: Colors.black38,
      fontSize: CustomAppTheme.screenHeight * 3 / 100,
      fontWeight: FontWeight.w300);
  static TextStyle signupHelperText = TextStyle(
      color: Colors.black38,
      fontSize: CustomAppTheme.screenHeight * 1 / 50,
      fontWeight: FontWeight.w300);

  static TextStyle signupErrorText = TextStyle(
      color: Colors.redAccent,
      fontSize: CustomAppTheme.screenHeight * 7 / 400,
      fontWeight: FontWeight.w300);

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerTextColor,
  );
  static const TextStyle subHeading = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.27,
    color: darkerTextColor,
  );

  static const TextStyle darkerTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: 0.3,
    color: darkerTextColor,
  );

  static const TextStyle darkTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.3,
    color: darkTextColor,
  );

  static const TextStyle lightTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.3,
    color: lightTextColor,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkTextColor,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkTextColor,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightTextColor, // was lightText
  );
}
