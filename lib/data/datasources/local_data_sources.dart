import 'package:test_flutter/common/exception.dart';
import 'package:test_flutter/data/datasources/db/database_helper.dart';
import 'package:test_flutter/data/models/user_table.dart';

abstract class LocalDataSources {
  Future<String> insertUser(UserTable user);
  Future<List<UserTable>> getListUser();
}

class LocalDataSourcesImpl implements LocalDataSources {
  final DatabaseHelper databaseHelper;

  LocalDataSourcesImpl({required this.databaseHelper});

  @override
  Future<String> insertUser(UserTable user) async {
    try {
      await databaseHelper.insertUser(user);
      return 'Added';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<UserTable>> getListUser() async {
    final result = await databaseHelper.getListUser();
    return result.map((data) => UserTable.fromMap(data)).toList();
  }
}
