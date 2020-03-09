import 'package:corona_app/src/modules/numbers/models/covid_daily_model.dart';

class DailyCovidResponse {
  int confirmed, deaths, recovered, percentDeath, percentRecovered;
  List<CovidDailyModel> data;

  DailyCovidResponse({this.data});

  factory DailyCovidResponse.fromJson(Map<String, dynamic> json) {
    var tempList = json["data"] as List;
    List<CovidDailyModel> listItems = [];
    tempList.forEach((json) {
      CovidDailyModel covid = CovidDailyModel.fromJson(json);
      listItems.add(covid);
    });

    return DailyCovidResponse(
      data: listItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
    };
  }
}
