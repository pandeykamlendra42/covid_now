import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/modules/main/screens/main_screen.dart';
import 'package:corona_app/src/modules/numbers/bloc/numbers_data_bloc.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NumbersDataBloc _dataBloc;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    if (_dataBloc == null) {
      _dataBloc = NumbersDataBloc();
      _dataBloc.stream.listen((response) {
        Navigator.pushReplacementNamed(_context, MainScreen.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomAppTheme.screenHeight = MediaQuery.of(context).size.height;
    CustomAppTheme.screenWidth = MediaQuery.of(context).size.width;
    _context = context;
    return Container(
      height: CustomAppTheme.screenHeight,
      width: CustomAppTheme.screenWidth,
      color: CustomAppTheme.primaryColor,
      alignment: Alignment.center,
      child: Container(
        height: 100,
        width: 100,
        child: Icon(
          Icons.security,
          color: Colors.amber,
          size: 100,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dataBloc.dispose();
    super.dispose();
  }
}
