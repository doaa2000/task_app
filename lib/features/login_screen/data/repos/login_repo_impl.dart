import 'package:task_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:task_app/core/utils/api_services.dart';
import 'package:task_app/core/utils/end_points.dart';
import 'package:task_app/features/login_screen/data/models/login_model/login_model/user.dart';
import 'package:task_app/features/login_screen/data/repos/login_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

String accessToken = '';

class LoginRepoImpl extends LoginRepo {
  final ApiService apiService;

  LoginRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, Map<String, dynamic>>> userLogin(
      {required String email, required String password}) async {
    try {
      var data = await apiService.post(endPoint: EndPoints.login, data: {
        'email': email,
        'password': password,
      });

      await storage.write(
          key: 'refreshToken',
          value: data['payload']['data'][0]['refresh_token']);
      accessToken = data['payload']['data'][0]['access_token'];
      print("hello access token ${data['payload']['data'][0]['access_token']}");
      print(
          "hello refresh token ${data['payload']['data'][0]['refresh_token']}");
      return right(data['payload']['data'][0]['user']);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    final refreshToken = await storage.read(key: 'refreshToken');
    try {
      var response = await apiService.post(
          endPoint: EndPoints.refreshToken,
          authorization: "Bearer $refreshToken");

      if (response['payload']['status_code'] == 200) {
        apiService.addToken(response['payload']['data']['accessToken']);
        await storage.write(
            key: "accessToken",
            value: response['payload']['data']['accessToken']);
      }
      return right(response);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
