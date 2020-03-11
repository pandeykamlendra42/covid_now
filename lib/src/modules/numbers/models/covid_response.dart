import 'package:corona_app/src/modules/numbers/models/daily_covid_response.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';

class CovidResponse {
  DailyCovidResponse dailyCovidResponse;
  WorldListResponse worldListResponse;

  CovidResponse({this.dailyCovidResponse, this.worldListResponse});
}
