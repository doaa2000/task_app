import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_app/features/login_screen/data/repos/login_repo.dart';
import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:get/get.dart';

part 'auth_state.dart';

class authCubit extends Cubit<LoginState> {
  authCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;
  static authCubit get(BuildContext context) => BlocProvider.of(context);
  Future<void> userLogin(
      {required String email, required String password}) async {
    var result = await loginRepo.userLogin(email: email, password: password);
    result.fold((failure) {
      emit(LoginFailure(errorMessage: failure.errorMessage));
    }, (r) {
      emit(LoginSuccess(user: r));
    });
  }

  Future<void> refreshToken() async {
    var result = await loginRepo.refreshToken();
    result.fold((failure) {
      if (failure.isTokenExpired == true) {
        loginRepo.storage.deleteAll();
      }
      emit(RefreshTokenExpired(
          errorMessage: failure.errorMessage,
          isTokenExpired: failure.isTokenExpired));
    }, (r) {
      emit(RefreshTokenSuccess());
    });
  }

  Future<bool> isRefreshTokenValid() async {
    refreshToken();
    if (await loginRepo.storage.containsKey(key: 'refreshToken')) {
      return true;
    }
    return false;
  }

  Future<void> userLogout() async {
    await loginRepo.storage.deleteAll().then((value) {
      emit(LogoutSuccess());
      Get.offAll(() => const LoginView());
    });
  }
}
