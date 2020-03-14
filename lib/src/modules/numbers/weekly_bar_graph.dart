import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/disclaimer_page.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/daily_covid_response.dart';

class WeeklyBarGraph extends StatefulWidget {
  final WorldListResponse listResponse;

  WeeklyBarGraph({@required this.listResponse});

  @override
  State<StatefulWidget> createState() => WeeklyBarGraphState();
}

class WeeklyBarGraphState extends State<WeeklyBarGraph> {
  bool isShowingMainData;
  final double barWidth = 7;
  var x_coordinate = 4;
  var y_coordinate = 10.0;
  List<String> weekDays = [];

  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        gradient: LinearGradient(
          colors: const [
            Color(0xff2D4361),
            Color(0xff2D4361),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Last 7 days",
                  style: TextStyle(
                      fontFamily: CustomAppTheme.fontName,
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: CustomAppTheme.accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "Infected",
                        style: TextStyle(
                            fontFamily: CustomAppTheme.fontName,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: CustomAppTheme.themeGreenColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "Recovered",
                        style: TextStyle(
                            fontFamily: CustomAppTheme.fontName,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 10.0),
                  child: FutureBuilder(
                      future: PreferenceManager().getDailyCovidResponse(),
                      builder: (_, AsyncSnapshot<DailyCovidResponse> snapshot) {
                        if (snapshot.hasData) {
                          return _getBarChart(snapshot.data);
                        }
                        return Container();
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                Navigator.pushNamed(context, DisclaimerPage.routeName);
              },
            ),
          )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: CustomAppTheme.accentColor,
        width: barWidth,
      ),
      BarChartRodData(
        y: y2,
        color: CustomAppTheme.themeGreenColor,
        width: barWidth,
      ),
    ]);
  }

  Widget _getBarChart(DailyCovidResponse data) {
    List<BarChartGroupData> items = [];
    x_coordinate = 0;
    y_coordinate = 0;
    var tempI = 0, tempR = 0, count = 0;
    weekDays.clear();
    data.data.reversed.forEach((covid) {
      if (tempI != 0 && count < 8) {
        if (covid.confirmed != null && covid.recovered != null) {
          x_coordinate += 3;
          y_coordinate = ((tempI - covid.confirmed) / 1000);
          items.add(makeGroupData(
              x_coordinate, y_coordinate, (tempR - covid.recovered) / 1000));
        }
        var date = DateFormat("yyyy/MM/dd").parse(covid.date);
        weekDays.add(DateFormat('EE').format(date));
      }
      tempI = covid.confirmed;
      tempR = covid.recovered;
      count++;
    });
    rawBarGroups.clear();
    items.reversed.forEach((bar) {
      rawBarGroups.add(bar);
    });

    showingBarGroups = rawBarGroups;
    return BarChart(
      BarChartData(
        maxY: 20,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                fontFamily: CustomAppTheme.fontName,
                color: Colors.white70,
                fontWeight: FontWeight.w300,
                fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              if (weekDays.length > value.toInt()) {
                return weekDays[6 - value.toInt()];
              }
              return "";
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                fontFamily: CustomAppTheme.fontName,
                color: Colors.white70,
                fontWeight: FontWeight.w300,
                fontSize: 14),
            margin: 32,
            reservedSize: 14,
            getTitles: (value) {
              switch(value.toInt()) {
                case 0:
                  return '1k';
                case 5:
                  return '5k';
                case 10:
                  return '10k';
                case 15:
                  return '15k';
                case 20:
                  return '20k';
              }
            },
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: showingBarGroups,
      ),
    );
  }
}
