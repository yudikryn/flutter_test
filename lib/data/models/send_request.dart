import 'package:test_flutter/domain/entities/city.dart';

class SendRequest {
  String name;
  String address;
  City city;
  SendRequest({required this.name, required this.address, required this.city, });
}