import 'package:corona_app/src/core/network_handler/api_base_helper.dart';
import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/utils/url_utils.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';

class NumbersDataRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Map<String, String> headers = {'Content-type': 'application/json'};

  Future<dynamic> getData() async {
    var requestUrl = UrlUtils.worldApiUrl;

    final response = await _helper.get(requestUrl);
    WorldListResponse listResponse = WorldListResponse.fromJson(response);
    PreferenceManager().saveWorldListResponse(listResponse);
    return listResponse;
  }
}
