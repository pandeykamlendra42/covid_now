import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyCurveGraph extends StatefulWidget {
  final WorldListResponse listResponse;

  MonthlyCurveGraph({@required this.listResponse});

  @override
  State<StatefulWidget> createState() => MonthlyCurveGraphState();
}

class MonthlyCurveGraphState extends State<MonthlyCurveGraph> {
  bool isShowingMainData;
  final double barWidth = 7;


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
                  "Febraury 2020",
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

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: const LineTouchData(
        enabled: false,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
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
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          margin: 8,
          reservedSize: 20,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: const BorderSide(
              color: Colors.white70,
              width: 1,
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
          )),
      minX: 0,
      maxX: 14,
      maxY: 6,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      const LineChartBarData(
        spots: [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: [
          CustomAppTheme.themeRedColor,
        ],
        barWidth: 0.5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          Color(0x33C82424),
        ]),
      ),
      const LineChartBarData(
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
          CustomAppTheme.accentColor,
        ],
        barWidth: 0.5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          Color(0x3341B7C7),
        ]),
      ),
    ];
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


  Widget _getBarChart() {
    return LineChart(
      sampleData2(),
      swapAnimationDuration: Duration(milliseconds: 250),
    );
  }
}
