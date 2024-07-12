import 'package:dartz/dartz.dart';
import 'package:test_flutter/common/failure.dart';
import 'package:test_flutter/domain/entities/user.dart';
import 'package:test_flutter/domain/repositories/repository.dart';

class GetListUser {
  final Repository repository;

  GetListUser(this.repository);

  Future<Either<Failure, List<User>>> execute() {
    return repository.getListUser();
  }
}
