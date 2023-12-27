import 'package:task_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:task_app/features/login_screen/data/models/login_model/login_model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LoginRepo {
  var storage = const FlutterSecureStorage();
  Future<Either<Failure, Map<String, dynamic>>> userLogin(
      {required String email, required String password});

  Future<Either<Failure, void>> refreshToken();
}
