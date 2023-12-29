import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/utils/api_services.dart';
import 'package:task_app/core/utils/constatnts.dart';
import 'package:task_app/core/utils/end_points.dart';

import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
part 'auth_state.dart';

class authCubit extends Cubit<LoginState> {
  authCubit(this._apiService) : super(LoginInitial());
  final ApiService _apiService;
  static authCubit get(BuildContext context) => BlocProvider.of(context);
  Future<void> userLogin(
      {required String email, required String password}) async {
    try {
      var response = await _apiService.post(endPoint: EndPoints.login, data: {
        'email': email,
        'password': password,
      });
      print(
          "refresh token befrore refresh api ${response['payload']['data'][0]['refresh_token']}");
      storage.write(
          key: 'refreshToken',
          value: response['payload']['data'][0]['refresh_token']);
      storage.write(
          key: 'accessToken',
          value: response['payload']['data'][0]['access_token']);
      emit(LoginSuccess());
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        emit(LoginFailure(errorMessage: "Token Expired"));
        return Future.error("Token Expired");
      } else {
        emit(LoginFailure(errorMessage: error.message ?? ''));
        return Future.error(error.message ?? '');
      }
    } catch (exception) {
      emit(LoginFailure(errorMessage: exception.toString()));
      return Future.error(exception.toString());
    }
  }

  // Future<bool> isRefreshTokenValid() async {
  //   refreshToken();
  //   if (await storage.containsKey(key: 'refreshToken')) {
  //     return true;
  //   }
  //   return false;
  // }

  Future<void> userLogout() async {
    await storage.deleteAll().then((value) {
      emit(LogoutSuccess());
      Get.offAll(() => const LoginView());
    });
  }
}
