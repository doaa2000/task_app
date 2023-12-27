import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/errors/failures.dart';
import 'package:task_app/features/users_screen/data/models/users_model/users_model/users_model.dart';
import 'package:task_app/features/users_screen/data/repos/users_repo.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._usresRepo) : super(UsersInitial());
  final UsresRepo _usresRepo;
  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> fetchUsers() async {
    emit(GetUsersLoading());
    var response = await _usresRepo.fetchUsers();
    response.fold((failure) {
      emit(GetUsersFailure(errorMessage: failure.errorMessage));
    }, (usersData) {
      emit(GetUsersSuccess(usersModel: usersData));
    });
  }
}
