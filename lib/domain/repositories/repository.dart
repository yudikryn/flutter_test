import 'package:dartz/dartz.dart';
import 'package:test_flutter/common/failure.dart';
import 'package:test_flutter/data/models/send_request.dart';
import 'package:test_flutter/data/models/user_table.dart';
import 'package:test_flutter/domain/entities/city.dart';
import 'package:test_flutter/domain/entities/send.dart';
import 'package:test_flutter/domain/entities/user.dart';

abstract class Repository {
  Future<Either<Failure, List<City>>> getCity();
  Future<Either<Failure, Send>> sendData(SendRequest sendRequest);
  Future<Either<Failure, String>> insertUser(UserTable user);
  Future<Either<Failure, List<User>>> getListUser();
}
