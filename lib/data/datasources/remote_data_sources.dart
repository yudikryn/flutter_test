import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_flutter/common/exception.dart';
import 'package:test_flutter/data/models/city_response.dart';
import 'package:test_flutter/data/models/send_request.dart';
import 'package:test_flutter/data/models/send_response.dart';

abstract class RemoteDataSources {
  Future<List<CityModel>> getCity();
  Future<SendResponse> sendData(SendRequest sendRequest);
}

class RemoteDataSourcesImpl implements RemoteDataSources {
  static const BASE_URL = 'https://private-1a3c32-getcity3.apiary-mock.com';

  final http.Client client;

  RemoteDataSourcesImpl({required this.client});

  @override
  Future<List<CityModel>> getCity() async {
    final response = await client.get(Uri.parse('$BASE_URL/city'));

    if (response.statusCode == 200) {
      return cityModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SendResponse> sendData(SendRequest sendRequest) async {
     final Map<String, String> field = {
      'name': sendRequest.name,
      'city': sendRequest.city.id.toString(),
      'address': sendRequest.address,
    };

    final response = await client.post(
      Uri.parse("$BASE_URL/guest"),
      body: field,
    );

    if (response.statusCode == 201) {
      return SendResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
