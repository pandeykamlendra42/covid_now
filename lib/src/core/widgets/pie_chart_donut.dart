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
  static List<charts.Series<LinearSales, int>> _createSampleData(
      WorldListResponse worldListResponse) {
    final data = [
      new LinearSales(0, worldListResponse.confirmed),
      new LinearSales(1, worldListResponse.recovered),
      new LinearSales(2, worldListResponse.deaths),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
