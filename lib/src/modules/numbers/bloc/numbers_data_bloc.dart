import 'dart:async';

import 'package:corona_app/src/core/network_handler/api_response.dart';
import 'package:corona_app/src/modules/numbers/repository/numbers_data_repository.dart';

class NumbersDataBloc {
  NumbersDataRepository _repository;

  StreamController _streamController;

  StreamSink<ApiResponse<dynamic>> get sink =>
      _streamController.sink;

  Stream<ApiResponse<dynamic>> get stream =>
      _streamController.stream;

  NumbersDataBloc() {
    _streamController = StreamController<ApiResponse<dynamic>>();
    _repository = NumbersDataRepository();
    getData();
  }

  getData() async {
    sink.add(ApiResponse.loading('Requesting'));
    try {
      var detailsResponse = await _repository.getData();
      sink.add(ApiResponse.completed(detailsResponse));
    } catch (e) {
      sink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}
