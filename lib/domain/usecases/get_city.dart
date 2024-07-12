import 'package:dartz/dartz.dart';
import 'package:test_flutter/common/failure.dart';
import 'package:test_flutter/domain/entities/city.dart';
import 'package:test_flutter/domain/repositories/repository.dart';

class GetCity {
  final Repository repository;

  GetCity(this.repository);

  Future<Either<Failure, List<City>>> execute() {
    return repository.getCity();
  }
}
