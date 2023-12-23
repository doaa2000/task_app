import 'package:task_app/core/utils/api_services.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final getit = GetIt.instance;

void setup() {
  GetIt.instance.registerLazySingleton<ApiService>(() => ApiService());
}
