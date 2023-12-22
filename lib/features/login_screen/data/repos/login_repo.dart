import 'package:dartz/dartz.dart';
import 'package:task_app/core/errors/failure.dart';
import 'package:task_app/features/login_screen/data/models/login_model/login_model/login_model.dart';
import 'package:task_app/features/login_screen/data/models/login_model/login_model/user.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> userLogin(
      {required String email, required String password});
}
