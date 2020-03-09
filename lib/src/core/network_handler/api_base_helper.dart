import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:corona_app/src/core/constants/app_constants.dart';
import 'api_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  final String _baseUrl = AppConstants.API_URL_STAGING;

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<dynamic> get(String url) async {
    print('Method GET,  ${_baseUrl + url}');
    var responseJson;

    try {
      final response = await http.get(_baseUrl + url, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Method POST,  ${_baseUrl + url}');
    print("body: $body");
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url,
          body: jsonEncode(body), headers: headers);
      print(response);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post. $responseJson');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Method PUT,  ${_baseUrl + url}');
    print("body: $body");
    var responseJson;

    try {
      print("header :: $headers");
      final response = await http.put(_baseUrl + url,
          body: jsonEncode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> patch(String url, dynamic body) async {
    print('Method PATCH,  ${_baseUrl + url}');
    print("body: $body");
    var responseJson;

    try {
      print("header :: $headers");
      final response = await http.patch(_baseUrl + url,
          body: jsonEncode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Method DELETE,  ${_baseUrl + url}');
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url, headers: headers);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  print(response.body.toString());
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
