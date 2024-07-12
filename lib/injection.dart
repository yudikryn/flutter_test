import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:test_flutter/data/datasources/db/database_helper.dart';
import 'package:test_flutter/data/datasources/local_data_sources.dart';
import 'package:test_flutter/data/datasources/remote_data_sources.dart';
import 'package:test_flutter/data/repositories/repository_impl.dart';
import 'package:test_flutter/domain/repositories/repository.dart';
import 'package:test_flutter/domain/usecases/get_city.dart';
import 'package:test_flutter/domain/usecases/get_list_user.dart';
import 'package:test_flutter/domain/usecases/insert_user.dart';
import 'package:test_flutter/domain/usecases/send_data.dart';
import 'package:test_flutter/presentation/provider/my_notifier.dart';
import 'package:test_flutter/presentation/provider/user_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MyNotifier(
      getCity: locator(),
      sendData: locator(),
    ),
  );
  locator.registerFactory(
    () => UserNotifier(
      getListUser: locator(),
    ),
  );
  // use case
  locator.registerLazySingleton(() => GetCity(locator()));
  locator.registerLazySingleton(() => SendData(locator()));
  locator.registerLazySingleton(() => InsertUser(locator()));
  locator.registerLazySingleton(() => GetListUser(locator()));
  // repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSources: locator(),
      localDataSources: locator(),
    ),
  );
  // data sources
  locator.registerLazySingleton<RemoteDataSources>(
      () => RemoteDataSourcesImpl(client: locator()));
  locator.registerLazySingleton<LocalDataSources>(
      () => LocalDataSourcesImpl(databaseHelper: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
