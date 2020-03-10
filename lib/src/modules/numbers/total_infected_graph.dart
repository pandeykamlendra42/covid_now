import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/disclaimer_page.dart';
import 'package:corona_app/src/modules/numbers/models/daily_covid_response.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalInfectedGraph extends StatefulWidget {
  final WorldListResponse listResponse;

  TotalInfectedGraph({@required this.listResponse});

  @override
  State<StatefulWidget> createState() => TotalInfectedGraphState();
}

class TotalInfectedGraphState extends State<TotalInfectedGraph> {
  bool isShowingMainData;
  var dataMaxX = 4.0;
  var dataMaxY = 10.0;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = new NumberFormat("#,###,###", "en_US");
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
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Total Infected",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: CustomAppTheme.fontName,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${numberFormat.format(widget.listResponse.confirmed)}",
                  style: TextStyle(
                      fontFamily: CustomAppTheme.fontName,
                      color: const Color(0xff41B7C7),
                      fontSize: 40,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                  child: FutureBuilder(
                      future: PreferenceManager().getDailyCovidResponse(),
                      builder: (_, AsyncSnapshot<DailyCovidResponse> snapshot) {
                        if (snapshot.hasData) {
                          return LineChart(
                            sampleData1(snapshot.data),
                            swapAnimationDuration: Duration(milliseconds: 250),
                          );
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

  LineChartData sampleData1(DailyCovidResponse data) {
    List<FlSpot> spots = [];
    List<FlSpot> spotsR = [];
    dataMaxX = 0;
    data.data.forEach((covid) {
      var day = int.parse(covid.date
          .substring(covid.date.lastIndexOf("/") + 1, covid.date.length));
      if (covid.confirmed != null && (day % 10) == 0) {
        dataMaxX += 3.5;
        dataMaxY = (covid.confirmed / 10000);
        spots.add(FlSpot(dataMaxX, dataMaxY));
      }
      if (covid.recovered != null && (day % 10) == 0) {
        //dataMaxX += 1;
        spotsR.add(FlSpot(dataMaxX, (covid.recovered / 10000)));
      }
      print("data(x, y) : ($dataMaxX, $dataMaxY), ${spots.length}");
    });
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
            fontFamily: CustomAppTheme.fontName,
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
            fontFamily: CustomAppTheme.fontName,
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
              case 6:
                return '70k';
              case 7:
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
      minX: 1,
      maxX: dataMaxX,
      maxY: dataMaxY,
      minY: 0,
      lineBarsData: linesBarData1(spots, spotsR),
    );
  }

  List<LineChartBarData> linesBarData1(
      List<FlSpot> spots, List<FlSpot> spotsR) {
    LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: spots,
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
    LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: spotsR,
      isCurved: true,
      colors: [
        Color(0xffB7F86D),
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
      // lineChartBarData3,
    ];
  }
}
