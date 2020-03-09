import 'dart:convert';

import 'package:corona_app/src/core/storage/preferences/preferences_key.dart';
import 'package:corona_app/src/modules/numbers/models/covid_location_model.dart';
import 'package:corona_app/src/modules/numbers/models/world_list_response.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PreferenceManager {
  SharedPreferences _sharedPreferences;

  PreferenceManager();

  saveWorldListResponse(WorldListResponse worldListResponse) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString(
        PreferencesKey.worldListResponse, jsonEncode(worldListResponse.toJson()));
  }

  Future<WorldListResponse> getWorldResponse() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String worldInfo =
        _sharedPreferences.getString(PreferencesKey.worldListResponse);
    print("sharedPreferences = await SharedPreferences.getInstance();::  $worldInfo");
    return worldInfo != null && worldInfo.isNotEmpty
        ? WorldListResponse.fromJson(jsonDecode(worldInfo) as Map<String, dynamic>)
        : null;
  }
  Future<WorldListResponse> getCountryResponse(String countryName) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String worldInfo =
    _sharedPreferences.getString(PreferencesKey.worldListResponse);
    print("sharedPreferences = await SharedPreferences.getInstance();::  $worldInfo");
    if(worldInfo != null && worldInfo.isNotEmpty){
      var worldResponse = WorldListResponse.fromJson(jsonDecode(worldInfo) as Map<String, dynamic>);
      worldResponse.data.forEach((covid){
        if(covid.country.toLowerCase().contains(countryName.toLowerCase())) {

        }
      });
    }
    return worldInfo != null && worldInfo.isNotEmpty
        ? WorldListResponse.fromJson(jsonDecode(worldInfo) as Map<String, dynamic>)
        : null;
  }

  Future<bool> clearAll() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return await _sharedPreferences.clear();
  }

}
