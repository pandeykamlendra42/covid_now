import 'package:corona_app/src/core/widgets/pie_chart_donut.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Infected", () => 5);
    dataMap.putIfAbsent("Recovered", () => 3);
    dataMap.putIfAbsent("Deaths", () => 2);

    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        color: Color(0xff2D4361),
        elevation: 5,
        child: Container(
          alignment: Alignment.center,
          height: 100,
          width: 100,
          child: Container(),
        ),
      ),
    );
  }
}
