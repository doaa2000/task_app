import 'package:task_app/core/utils/api_services.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:task_app/features/login_screen/data/repos/login_repo_impl.dart';

final getit = GetIt.instance;

void setup() {
  getit.registerSingleton<ApiService>(ApiService(Dio()));
  getit.registerSingleton<LoginRepoImpl>(
      LoginRepoImpl(apiService: getit.get<ApiService>()));
}
