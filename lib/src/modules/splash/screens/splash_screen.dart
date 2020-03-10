import 'package:corona_app/src/core/network_handler/api_response.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/network_error_widget.dart';
import 'package:corona_app/src/modules/main/screens/main_screen.dart';
import 'package:corona_app/src/modules/numbers/bloc/numbers_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NumbersDataBloc _dataBloc;

  @override
  void initState() {
    super.initState();
    if (_dataBloc == null) {
      _dataBloc = NumbersDataBloc();
      _dataBloc.stream.listen((response) {
        if (response.status == Status.COMPLETED || response.status == Status.ERROR) {
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
        } else if (response.status == Status.CONNECTION_ERROR) {
          Navigator.pushNamed(context, ConnectionScreen.routeName).then((v) {
            _dataBloc.getData();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomAppTheme.screenHeight = MediaQuery.of(context).size.height;
    CustomAppTheme.screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: CustomAppTheme.screenHeight,
      width: CustomAppTheme.screenWidth,
      color: CustomAppTheme.primaryColor,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              child: SvgPicture.asset("assets/images/app_icon.svg"),
            )
          ],
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
