import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarGraph extends StatefulWidget {
  final WorldListResponse listResponse;

  WeeklyBarGraph({@required this.listResponse});

  @override
  State<StatefulWidget> createState() => WeeklyBarGraphState();
}

class WeeklyBarGraphState extends State<WeeklyBarGraph> {
  bool isShowingMainData;
  final double barWidth = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;

    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
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
                        color: CustomAppTheme.themeRedColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "Deaths",
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
                  child: _getBarChart(),
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

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {
          print(touchResponse);
        },
        handleBuiltInTouches: true,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 1,
          textStyle: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 7:
                return 'Feb';
              case 12:
                return 'Mar';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1k';
              case 2:
                return '10k';
              case 3:
                return '20k';
              case 4:
                return '50k';
              case 5:
                return '100k';
            }
            return '';
          },
          margin: 10,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: const BorderSide(
            color: Colors.white70,
            width: 0.5,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 5,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    LineChartBarData lineChartBarData1 = const LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 3.2),
        FlSpot(13, 5.8),
      ],
      isCurved: true,
      colors: [
        Color(0xffd68709),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    LineChartBarData lineChartBarData3 = const LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: [
        Color(0xff991611),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData3,
    ];
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
        color: CustomAppTheme.themeRedColor,
        width: barWidth,
      ),
    ]);
  }

  Widget _getBarChart() {
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
              switch (value.toInt()) {
                case 0:
                  return 'Mon';
                case 1:
                  return 'Tue';
                case 2:
                  return 'Wed';
                case 3:
                  return 'Thu';
                case 4:
                  return 'Fri';
                case 5:
                  return 'Sat';
                case 6:
                  return 'Sun';
                default:
                  return '';
              }
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
