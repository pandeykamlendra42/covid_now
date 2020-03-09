class CovidLocationModel {
  int confirmed, deaths, recovered, lastUpdated;
  dynamic lat, lng;
  String country;

  CovidLocationModel(
      {this.confirmed,
      this.deaths,
      this.recovered,
      this.lastUpdated,
      this.lat,
      this.lng,
      this.country});

  factory CovidLocationModel.fromJson(Map<String, dynamic> json) {
    return CovidLocationModel(
      confirmed: json["confirmed"],
      deaths: json["deaths"],
      recovered: json["recovered"],
      lastUpdated: json["lastUpdated"],
      lat: json["lat"],
      lng: json["lng"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'confirmed': confirmed,
      'deaths': deaths,
      'recovered': recovered,
      'lastUpdated': lastUpdated,
      'lat': lat,
      'lng': lng,
      'country': country,
    };
  }
}
