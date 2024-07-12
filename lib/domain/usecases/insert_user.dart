import 'package:dartz/dartz.dart';
import 'package:test_flutter/common/failure.dart';
import 'package:test_flutter/data/models/user_table.dart';
import 'package:test_flutter/domain/repositories/repository.dart';

class InsertUser {
  final Repository repository;

  InsertUser(this.repository);

  Future<Either<Failure, String>> execute(UserTable user) {
    return repository.insertUser(user);
  }
}
