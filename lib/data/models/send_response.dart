import 'dart:convert';

import 'package:test_flutter/domain/entities/data.dart';
import 'package:test_flutter/domain/entities/send.dart';

SendResponse responseSendFromJson(String str) =>
    SendResponse.fromJson(json.decode(str));

String responseSendToJson(SendResponse data) => json.encode(data.toJson());

class SendResponse {
  final String message;
  final DataResponse data;

  SendResponse({
    required this.message,
    required this.data,
  });

  factory SendResponse.fromJson(Map<String, dynamic> json) => SendResponse(
        message: json["message"],
        data: DataResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };

  Send toEntity() {
    return Send(message: this.message, data: this.data.toEntity());
  }
}

class DataResponse {
  String name;
  String address;
  int city;

  DataResponse({
    required this.name,
    required this.address,
    required this.city,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
        name: json["name"],
        address: json["address"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "city": city,
      };

  Data toEntity() {
    return Data(name: this.name, address: this.address, city: this.city);
  }
}
