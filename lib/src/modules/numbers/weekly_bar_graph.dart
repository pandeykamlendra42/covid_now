import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
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
  var dataMaxX = 4;
  var dataMaxY = 10.0;
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
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
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
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    List<BarChartGroupData> items = [];
    List<FlSpot> spots = [];
    List<FlSpot> spotsR = [];
    dataMaxX = 0;
    var tempI = 0, tempR = 0, count = 0;
    weekDays.clear();
    data.data.reversed.forEach((covid) {
      if (tempI != 0 && count < 8) {
        if (covid.confirmed != null && covid.recovered != null) {
          dataMaxX += 3;
          dataMaxY = ((tempI - covid.confirmed) / 200);
          items.add(makeGroupData(
              dataMaxX, dataMaxY, (tempR - covid.recovered) / 200));
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
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (_a, _b, _c, _d) => null,
            ),
            touchCallback: (response) {
              if (response.spot == null) {
                setState(() {
                  touchedGroupIndex = -1;
                  showingBarGroups = List.of(rawBarGroups);
                });
                return;
              }

              touchedGroupIndex = response.spot.touchedBarGroupIndex;

              setState(() {
                if (response.touchInput is FlLongPressEnd ||
                    response.touchInput is FlPanEnd) {
                  touchedGroupIndex = -1;
                  showingBarGroups = List.of(rawBarGroups);
                } else {
                  showingBarGroups = List.of(rawBarGroups);
                  if (touchedGroupIndex != -1) {
                    double sum = 0;
                    for (BarChartRodData rod
                        in showingBarGroups[touchedGroupIndex].barRods) {
                      sum += rod.y;
                    }
                    final avg = sum /
                        showingBarGroups[touchedGroupIndex].barRods.length;

                    showingBarGroups[touchedGroupIndex] =
                        showingBarGroups[touchedGroupIndex].copyWith(
                      barRods: showingBarGroups[touchedGroupIndex]
                          .barRods
                          .map((rod) {
                        return rod.copyWith(y: avg);
                      }).toList(),
                    );
                  }
                }
              });
            }),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
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
                color: Colors.white70,
                fontWeight: FontWeight.w300,
                fontSize: 14),
            margin: 32,
            reservedSize: 14,
            getTitles: (value) {
              if (value == 0) {
                return '1K';
              } else if (value == 10) {
                return '20K';
              } else if (value == 19) {
                return '100K';
              } else {
                return '';
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
