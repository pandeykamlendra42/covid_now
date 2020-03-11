import 'package:corona_app/src/modules/numbers/models/covid_daily_model.dart';

class DailyCovidResponse {
  int confirmed, deaths, recovered, percentDeath, percentRecovered;
  List<CovidDailyModel> data;

  DailyCovidResponse({this.data,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.percentDeath,
    this.percentRecovered});

  factory DailyCovidResponse.fromJson(Map<String, dynamic> json) {
    var tempList = json["data"] as List;
    List<CovidDailyModel> listItems = [];
    tempList.forEach((json) {
      CovidDailyModel covid = CovidDailyModel.fromJson(json);
      listItems.add(covid);
    });
    CovidDailyModel temp = listItems[listItems.length -1];

    return DailyCovidResponse(
      data: listItems,
      confirmed:  temp.confirmed,
      deaths: temp.deaths,
      recovered: temp.recovered
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}
