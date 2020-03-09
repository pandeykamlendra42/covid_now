class CovidDailyModel {
  int confirmed, deaths, recovered;
  String date;

  CovidDailyModel({this.confirmed, this.deaths, this.recovered, this.date});

  factory CovidDailyModel.fromJson(Map<String, dynamic> json) {
    return CovidDailyModel(
      confirmed: json["total_confirmed"],
      deaths: json["deaths"],
      recovered: json["total_recovered"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_confirmed': confirmed,
      'deaths': deaths,
      'total_recovered': recovered,
      'date': date,
    };
  }
}
