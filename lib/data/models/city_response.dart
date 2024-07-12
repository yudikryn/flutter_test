import 'dart:convert';
import 'package:test_flutter/domain/entities/city.dart';

List<CityModel> cityModelFromJson(String str) {
  String cleanedJsonString = str.replaceAllMapped(
      RegExp(r'"city": "(.*?)",'), (match) => '"city": "${match.group(1)}"');
  final jsonData = json.decode(cleanedJsonString);
  return List<CityModel>.from(jsonData.map((item) => CityModel.fromJson(item)));
}

String cityModelToJson(List<CityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  final int id;
  final String city;

  CityModel({
    required this.id,
    required this.city,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
      };

  City toEntity() {
    return City(id: this.id, city: this.city);
  }
}
