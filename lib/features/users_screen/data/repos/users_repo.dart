import 'package:dartz/dartz.dart';
import 'package:task_app/core/errors/failures.dart';
import 'package:task_app/features/users_screen/data/models/users_model/users_model/users_model.dart';

abstract class UsresRepo {
  Future<Either<Failure, UsersModel>> fetchUsers();
}
