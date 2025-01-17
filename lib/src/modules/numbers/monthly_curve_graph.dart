import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/disclaimer_page.dart';
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
  var x_coordinate = 4.0;
  var y_coordinate = 10.0;

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
                  "Monthly",
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
                          print('snapshot data found out');
                          print(snapshot.data);
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

  LineChartData sampleData2(DailyCovidResponse data) {
    List<FlSpot> spots = [];
    List<FlSpot> spotsR = [];
    x_coordinate = 0;
    y_coordinate = 0;
    double sumY = y_coordinate;
    var tempI = 0, tempR = 0;
    data.data.forEach((covid) {
      var day = int.parse(covid.date
          .substring(covid.date.lastIndexOf("/") + 1, covid.date.length));
      if (covid.confirmed != null && (day % 10) == 0) {
        x_coordinate += 10;
        y_coordinate = covid.confirmed.toDouble()/1000; //((covid.confirmed - tempI) / 1000);
        tempI = covid.confirmed;
        spots.add(FlSpot(x_coordinate, y_coordinate));
      }
      if (covid.recovered != null && (day % 10) == 0) {
        spotsR.add(FlSpot(x_coordinate, covid.recovered.toDouble()/1000));
        tempR = covid.recovered;
      }
      sumY += 1;
      print("data(x, y) : ($x_coordinate, $y_coordinate), ${spots.length}");
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
            fontFamily: CustomAppTheme.fontName,
            color: Colors.white70,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          margin: 10,
          getTitles: (value) {
            // print('value of horizontal tiles');
            // print(value);
            switch (value.toInt()) {
              case 11:
                return 'Jan';
              case 27:
                return 'Feb';
              case 43:
                return 'Mar';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            fontFamily: CustomAppTheme.fontName,
            color: Colors.white70,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          getTitles: (value) {
            // print('value of vertical tiles');
            // print(value.toInt());
            switch (value.toInt()) {
              case 50:
                return '50k';
              case 100:
                return '100k';
              case 150:
                return '150k';
              case 200:
                return '200k';
              case 250:
                return '250k';
              case 300:
                return '300k';
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
      maxX: x_coordinate + 1,
      maxY: y_coordinate + 1,
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
