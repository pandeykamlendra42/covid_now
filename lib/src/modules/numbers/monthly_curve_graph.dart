import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'models/daily_covid_response.dart';

class MonthlyCurveGraph extends StatefulWidget {
  final WorldListResponse listResponse;

  MonthlyCurveGraph({@required this.listResponse});

  @override
  State<StatefulWidget> createState() => MonthlyCurveGraphState();
}

class MonthlyCurveGraphState extends State<MonthlyCurveGraph> {
  bool isShowingMainData;
  final double barWidth = 7;
  var dataMaxX = 4.0;
  var dataMaxY = 10.0;

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

  LineChartData sampleData2(DailyCovidResponse data) {
    List<FlSpot> spots = [];
    List<FlSpot> spotsR = [];
    dataMaxX = 0;
    var tempI = 0, tempR = 0;
    data.data.forEach((covid) {
      var day = int.parse(covid.date
          .substring(covid.date.lastIndexOf("/") + 1, covid.date.length));
      if (covid.confirmed != null && (day % 10) == 0) {
        dataMaxX += 3.5;
        dataMaxY = ((covid.confirmed - tempI) / 10000);
        tempI = covid.confirmed;
        spots.add(FlSpot(dataMaxX, dataMaxY));
      }
      if (covid.recovered != null && (day % 10) == 0) {
        spotsR.add(FlSpot(dataMaxX, ((covid.recovered - tempR) / 10000)));
        tempR = covid.recovered;
      }
      print("data(x, y) : ($dataMaxX, $dataMaxY), ${spots.length}");
    });
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
                return '60k';
              case 4:
                return '100k';
              case 5:
                return '150k';
              case 6:
                return '170k';
            }
            return '';
          },
          margin: 10,
          reservedSize: 25,
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
      maxX: dataMaxX + 1,
      maxY: dataMaxY + 1,
      minY: 0,
      lineBarsData: linesBarData2(spots, spotsR),
    );
  }

  List<LineChartBarData> linesBarData2(
      List<FlSpot> spots, List<FlSpot> spotsR) {
    return [
      LineChartBarData(
        spots: spots,
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
      LineChartBarData(
        spots: spotsR,
        isCurved: true,
        colors: [
          CustomAppTheme.themeGreenColor,
        ],
        barWidth: 0.5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          CustomAppTheme.themeGreenColor.withOpacity(0.3)
        ]),
      ),
    ];
  }

  Widget _getBarChart(DailyCovidResponse data) {
    return LineChart(
      sampleData2(data),
      swapAnimationDuration: Duration(milliseconds: 250),
    );
  }
}
