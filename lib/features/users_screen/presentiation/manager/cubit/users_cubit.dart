import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/errors/failures.dart';
import 'package:task_app/core/utils/api_services.dart';
import 'package:task_app/core/utils/constatnts.dart';
import 'package:task_app/core/utils/end_points.dart';
import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:task_app/features/users_screen/data/models/users_model/users_model/users_model.dart';
import 'package:task_app/features/users_screen/data/repos/users_repo.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._apiService) : super(UsersInitial());
  final ApiService _apiService;
  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> fetchUsers() async {
    emit(GetUsersLoading());

    try {
      var response = await _apiService.get(endPoint: EndPoints.users);
      UsersModel usersModel = UsersModel.fromJson(response);
      emit(GetUsersSuccess(usersModel: usersModel));
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        emit(GetUsersFailure(errorMessage: "Token Expired"));
        return Future.error("Token Expired");
      } else {
        emit(GetUsersFailure(errorMessage: error.message ?? ""));
        return Future.error(error.message ?? '');
      }
    } catch (exception) {
      emit(GetUsersFailure(errorMessage: exception.toString()));
      return Future.error(exception.toString());
    }
  }
}
