import 'package:corona_app/src/modules/numbers/models/covid_location_model.dart';

class WorldListResponse {
  int confirmed, deaths, recovered, percentDeath, percentRecovered;
  List<CovidLocationModel> data;

  WorldListResponse(
      {this.data,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.percentDeath,
      this.percentRecovered});

  factory WorldListResponse.fromJson(Map<String, dynamic> json) {
    var tempList = json["data"] as List;
    print("data ${tempList.length}");
    int tConfirmed = 0, tDeaths = 0, tRecovered = 0;
    List<CovidLocationModel> listItems = [];
    tempList.forEach((json) {
      CovidLocationModel covid = CovidLocationModel.fromJson(json);
      tConfirmed += covid.confirmed;
      tDeaths += covid.deaths;
      tRecovered += covid.recovered;
      listItems.add(covid);
    });
    var perD = ((tDeaths / tConfirmed) * 100).round();
    var perR = ((tRecovered / tConfirmed) * 100).round();

    return WorldListResponse(
        data: listItems,
        confirmed: tConfirmed,
        deaths: tDeaths,
        recovered: tRecovered,
        percentDeath: perD,
        percentRecovered: perR
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'confirmed': confirmed,
      'deaths': deaths,
      'recovered': recovered,

    };
  }
}
