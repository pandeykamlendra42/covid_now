class CovidDailyModel {
  int confirmed, deaths, recovered, chinaConf, otherLocationConf;
  String date;

  CovidDailyModel(
      {this.confirmed,
      this.deaths,
      this.recovered,
      this.date,
      this.chinaConf,
      this.otherLocationConf});

  factory CovidDailyModel.fromJson(Map<String, dynamic> json) {
    return CovidDailyModel(
      confirmed: json["total_confirmed"] != null ? json["total_confirmed"] : 0,
      deaths: json["deaths"] != null ? json["deaths"] : 0,
      recovered: json["total_recovered"] != null ? json["total_recovered"] : 0,
      chinaConf: json["china_confirmed"] != null ? json["china_confirmed"] : 0,
      otherLocationConf: json["other_location_confirmed"] != null
          ? json["other_location_confirmed"]
          : 0,
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_confirmed': confirmed,
      'deaths': deaths,
      'total_recovered': recovered,
      'other_location_confirmed': otherLocationConf,
      'china_confirmed': chinaConf,
      'date': date,
    };
  }
}
