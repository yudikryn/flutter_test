import 'package:flutter/widgets.dart';
import 'package:test_flutter/common/state_enum.dart';
import 'package:test_flutter/data/models/send_request.dart';
import 'package:test_flutter/domain/entities/city.dart';
import 'package:test_flutter/domain/entities/send.dart';
import 'package:test_flutter/domain/usecases/get_city.dart';
import 'package:test_flutter/domain/usecases/send_data.dart';

class MyNotifier extends ChangeNotifier {
  final GetCity getCity;
  final SendData sendData;

  MyNotifier({required this.getCity, required this.sendData});

  RequestState _cityState = RequestState.Empty;
  RequestState get cityState => _cityState;

  String _message = '';
  String get message => _message;

  List<City> _listCity = [];
  List<City> get listCity => _listCity;

  RequestState _sendState = RequestState.Empty;
  RequestState get sendState => _sendState;

  late Send _send;
  Send get send => _send;

  Future<void> fetchCity() async {
    _cityState = RequestState.Loading;
    notifyListeners();
    final result = await getCity.execute();
    result.fold(
      (failure) {
        _cityState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (city) {
        _cityState = RequestState.Loaded;
        _listCity = city;
        notifyListeners();
      },
    );
  }

  Future<void> postData(SendRequest sendRequest) async {
    _sendState = RequestState.Loading;
    notifyListeners();
    final result = await sendData.execute(sendRequest);
    result.fold(
      (failure) {
        _sendState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (send) {
        _sendState = RequestState.Loaded;
        _send = send;
        notifyListeners();
      },
    );
  }
}
