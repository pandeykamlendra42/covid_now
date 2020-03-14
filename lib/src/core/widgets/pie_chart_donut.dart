import 'package:charts_flutter/flutter.dart' as charts;
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  static const colorMap = {
    0: '#3CC3D4',
    1: '#B7F86D',
    2: '#EC514E',
  };

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
      new CoronaCases(0, worldListResponse.confirmed),
      new CoronaCases(1, worldListResponse.recovered),
      new CoronaCases(2, worldListResponse.deaths),
    ];

    return [
      new charts.Series<CoronaCases, int>(
        id: 'Cases',
        domainFn: (CoronaCases report, _) => report.type,
        measureFn: (CoronaCases report, _) => report.reports,
        colorFn: (CoronaCases report, _) => charts.Color.fromHex(code: colorMap[report.type]),
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class CoronaCases {
  final int type;
  final int reports;

  CoronaCases(this.type, this.reports);
}
