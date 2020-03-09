import 'dart:math' as math;

import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:corona_app/src/modules/numbers/monthly_curve_graph.dart';
import 'package:corona_app/src/modules/numbers/total_infected_graph.dart';
import 'package:corona_app/src/modules/numbers/weekly_bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatsPage extends StatefulWidget {
  static final routeName = "./numbers";

  @override
  _StatsPageState createState() => _StatsPageState();
}

math.Random random = new math.Random();

List<double> _generateRandomData(int count) {
  List<double> result = <double>[];
  for (int i = 0; i < count; i++) {
    result.add(random.nextDouble() * 100);
  }
  return result;
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: CustomAppTheme.primaryColor,
        statusBarIconBrightness: Brightness.light));
    var data = _generateRandomData(10);
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          color: CustomAppTheme.primaryColor,
          child: _buildInfoWidget(),
        ),
      ),
    );
  }

  Widget _buildInfoWidget() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return FutureBuilder<WorldListResponse>(
      future: PreferenceManager().getWorldResponse(),
      builder: (_, AsyncSnapshot<WorldListResponse> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Countries",
                  style: TextStyle(
                      fontFamily: CustomAppTheme.fontName,
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10, bottom: 15),
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: CustomAppTheme.primaryColor,
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "World",
                          style: TextStyle(
                              fontFamily: CustomAppTheme.fontName,
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 1,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Container(
                  height: _height * 26 / 80,
                  width: _width * 0.87,
                  child: MonthlyCurveGraph(
                    listResponse: snapshot.data,
                  ),
                ),
              ),
              Card(
                elevation: 1,
                color: Colors.transparent,
                margin: EdgeInsets.only(top: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Container(
                  height: _height * 26 / 80,
                  width: _width * 0.87,
                  child: WeeklyBarGraph(
                    listResponse: snapshot.data,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
