import 'package:charts_flutter/flutter.dart' as charts;
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:flutter/material.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData(WorldListResponse worldListResponse) {
    return new DonutPieChart(
      _createSampleData(worldListResponse),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      animationDuration: Duration(milliseconds: 800),
      defaultRenderer: new charts.ArcRendererConfig(arcWidth: 30),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<CoronaCases, int>> _createSampleData(
      WorldListResponse worldListResponse) {
    final data = [
      new CoronaCases(0, worldListResponse.confirmed, '#3CC3D4'),
      new CoronaCases(1, worldListResponse.recovered, '#B7F86D'),
      new CoronaCases(2, worldListResponse.deaths, '#EC514E'),
    ];

    return [
      new charts.Series<CoronaCases, int>(
        id: 'Cases',
        domainFn: (CoronaCases report, _) => report.type,
        measureFn: (CoronaCases report, _) => report.reports,
        colorFn: (CoronaCases report, _) => charts.Color.fromHex(code: report.color),
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class CoronaCases {
  final int type;
  final int reports;
  final String color;

  CoronaCases(this.type, this.reports, this.color);
}
