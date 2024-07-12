import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:test_flutter/common/exception.dart';
import 'package:test_flutter/common/failure.dart';
import 'package:test_flutter/data/datasources/local_data_sources.dart';
import 'package:test_flutter/data/datasources/remote_data_sources.dart';
import 'package:test_flutter/data/models/send_request.dart';
import 'package:test_flutter/data/models/user_table.dart';
import 'package:test_flutter/domain/entities/city.dart';
import 'package:test_flutter/domain/entities/send.dart';
import 'package:test_flutter/domain/entities/user.dart';
import 'package:test_flutter/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSources remoteDataSources;
  final LocalDataSources localDataSources;

  RepositoryImpl(
      {required this.remoteDataSources, required this.localDataSources});

  @override
  Future<Either<Failure, List<City>>> getCity() async {
    try {
      final result = await remoteDataSources.getCity();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Send>> sendData(SendRequest sendRequest) async {
    try {
      final result = await remoteDataSources.sendData(sendRequest);
      await localDataSources.insertUser(UserTable(name: sendRequest.name, address: sendRequest.address, city: sendRequest.city.city));
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getListUser() async {
    final result = await localDataSources.getListUser();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, String>> insertUser(UserTable user) async {
    try {
      final result = await localDataSources.insertUser(user);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}
