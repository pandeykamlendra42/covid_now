import 'dart:io';

import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnectionScreen extends StatelessWidget {
  static const routeName = "./ConnectionScreen";

  ConnectionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: CustomAppTheme.primaryColor,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/no_internet.svg',
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                Text("No Network",
                    style: TextStyle(
                        fontFamily: CustomAppTheme.fontName,
                        color: Colors.white70,
                        fontSize: 24,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.left),

                Padding(
                  padding: EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 50),
                  child: Text(
                      "Network interupted. We will get back once you are connected",
                      style: TextStyle(
                          fontFamily: CustomAppTheme.fontName,
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center),
                ),
                Container(
                    child: Material(
                      color: Theme.of(context).accentColor,
                      shadowColor:
                          Theme.of(context).accentColor.withAlpha(70),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        onTap: () {
                          NetworkInfo().isConnected().then((val) {
                            if (val) {
                              Navigator.of(context).pop(Future.value(true));
                            }
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(
                            Icons.sync,
                            color: Colors.white,
                            size: _height * 1 / 27,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withAlpha(70),
                              blurRadius: 8.0,
                              spreadRadius: 3.0,
                              offset: Offset(
                                0.0,
                                3.0,
                              )),
                        ])),
              ],
            ),
          ),
        ),
        onWillPop: () {
          exit(0);
          return Future.value(false);
        });
  }
}
