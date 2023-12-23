import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_app/core/utils/api_services.dart';
import 'package:task_app/core/utils/end_points.dart';

import 'package:task_app/features/login_screen/data/models/login_model/login_model/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:fly_networking/AppException.dart';
import 'package:dio/dio.dart';
import 'package:task_app/features/login_screen/data/models/login_model/login_model/user.dart';
import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:get/get.dart';
part 'auth_state.dart';

class authCubit extends Cubit<LoginState> {
  authCubit() : super(LoginInitial());
  final ApiService _apiService = GetIt.I<ApiService>();

  static authCubit get(BuildContext context) => BlocProvider.of(context);
  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      var data = await _apiService.post(endPoint: EndPoints.login, data: {
        'email': email,
        'password': password,
      });

      User userModel = User.fromJson(data['payload']['data'][0]['user']);

      await _apiService.storage.write(
          key: 'refreshToken',
          value: data['payload']['data'][0]['refresh_token']);
      emit(LoginSuccess(user: userModel));
    } catch (error) {
      if (error.toString() == 'No Internet') {
        emit(LoginFailure(errorMessage: 'No internet connection'));
      } else {
        emit(LoginFailure(
            errorMessage: 'Phone number or Password is not correct'));
      }
    }
  }

  Future<void> refreshToken() async {
    final refreshToken = await _apiService.storage.read(key: 'refreshToken');

    try {
      final response = await _apiService.post(
          endPoint: EndPoints.refreshToken,
          authorization: "Bearer $refreshToken");
      if (response['payload']['status_code'] == 200) {
        await _apiService.storage.write(
            key: "accessToken",
            value: response['payload']['data']['accessToken']);
      }
    } on DioException catch (error) {
      emit(RefreshTokenExpired());
      if (error.response?.statusCode == 401) {
        _apiService.storage.deleteAll();
      }
    }
  }

  Future<bool> isRefreshTokenValid() async {
    refreshToken();
    if (await _apiService.storage.containsKey(key: 'refreshToken')) {
      return true;
    }
    return false;
  }

  Future<void> userLogout() async {
    await _apiService.storage.deleteAll().then((value) {
      emit(LogoutSuccess());
      Get.offAll(() => const LoginView());
    });
  }
}
