import 'package:test_flutter/domain/entities/data.dart';

class Send {
    String message;
    Data data;

    Send({
        required this.message,
        required this.data,
    });
}