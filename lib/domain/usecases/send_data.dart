import 'package:dartz/dartz.dart';
import 'package:test_flutter/common/failure.dart';
import 'package:test_flutter/data/models/send_request.dart';
import 'package:test_flutter/domain/entities/send.dart';
import 'package:test_flutter/domain/repositories/repository.dart';

class SendData {
  final Repository repository;

  SendData(this.repository);

  Future<Either<Failure, Send>> execute(SendRequest sendRequest) {
    return repository.sendData(sendRequest);
  }
}
