import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_app/core/utils/api_services.dart';
import 'package:task_app/core/utils/end_points.dart';
import 'package:task_app/features/login_screen/data/models/login_model/login_model/login_model.dart';
import 'package:task_app/features/login_screen/data/repos/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  final ApiService apiService = GetIt.I<ApiService>();
  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());

    // var result = await loginRepo.userLogin(email: email, password: password);

    try {
      var data = await apiService.post(endPoint: EndPoints.login, data: {
        'email': email,
        'password': password,
      });
      LoginModel loginModel = LoginModel.fromJson(data);
      emit(LoginSuccess(loginModel: loginModel));
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
