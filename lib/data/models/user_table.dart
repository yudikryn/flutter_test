import 'package:test_flutter/domain/entities/user.dart';

class UserTable {
  final String name;
  final String address;
  final String city;
  UserTable(
      {
      required this.name,
      required this.address,
      required this.city});

  factory UserTable.fromMap(Map<String, dynamic> map) => UserTable(
        name: map['name'],
        address: map['address'],
        city: map['city'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'city': city,
      };

  User toEntity() => User(name: name, address: address, city: city);
}
