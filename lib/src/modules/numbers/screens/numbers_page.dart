import 'dart:math' as math;

import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/country_picker.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:corona_app/src/modules/numbers/total_infected_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumbersPage extends StatefulWidget {
  static final routeName = "./numbers";
  String selectedCountry = "world";

  @override
  _NumbersPageState createState() => _NumbersPageState();
}

math.Random random = new math.Random();

List<double> _generateRandomData(int count) {
  List<double> result = <double>[];
  for (int i = 0; i < count; i++) {
    result.add(random.nextDouble() * 100);
  }
  return result;
}

class _NumbersPageState extends State<NumbersPage>
    with AutomaticKeepAliveClientMixin {
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
                margin: EdgeInsets.only(top: 5, bottom: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Overview",
                  style: TextStyle(
                      fontFamily: CustomAppTheme.fontName,
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w500),
                ),
              ),
//              Container(
//                alignment: Alignment.center,
//                margin: EdgeInsets.only(top: 10, bottom: 15),
//                child: CountryPickerWidget(callback: (country){
//
//                },),
//              ),
              Expanded(
                flex: 4,
                child: Card(
                  elevation: 1,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(

                    width: _width * 0.87,
                    child: TotalInfectedGraph(
                      listResponse: snapshot.data,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(top: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        elevation: 1,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Container(
                          width: _width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(
                              colors: const [
                                // Color(0xff2c274c),
                                // Color(0xff46426c),
                                Color(0xff2D4361),
                                Color(0xff2D4361),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 35),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Total \nDeaths",
                                  style: TextStyle(
                                      fontFamily: CustomAppTheme.fontName,
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                height: 50,
                                padding: EdgeInsets.only(left: 20),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "${snapshot.data.deaths}",
                                    style: TextStyle(
                                        fontFamily: CustomAppTheme.fontName,
                                        color: Color(0xFFC82424),
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: RichText(
                                  text: TextSpan(
                                      text: "${snapshot.data.percentDeath}%",
                                      style: TextStyle(
                                          fontFamily: CustomAppTheme.fontName,
                                          color: Color(0xFFC82424),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text: " of total",
                                          style: TextStyle(
                                              fontFamily: CustomAppTheme.fontName,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 20),
                        elevation: 1,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(
                              colors: const [
                                Color(0xff2D4361),
                                Color(0xff2D4361),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          width: _width * 0.4,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 35),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Total \nRecovered",
                                  style: TextStyle(
                                      fontFamily: CustomAppTheme.fontName,
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                height: 50,
                                padding: EdgeInsets.only(left: 20),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "${snapshot.data.recovered}",
                                    style: TextStyle(
                                        fontFamily: CustomAppTheme.fontName,
                                        color: Color(0xffB7F86D),
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: RichText(
                                  text: TextSpan(
                                      text: "${snapshot.data.percentRecovered}%",
                                      style: TextStyle(
                                          fontFamily: CustomAppTheme.fontName,
                                          color: Color(0xffB7F86D),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          text: " of total",
                                          style: TextStyle(
                                              fontFamily: CustomAppTheme.fontName,
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
