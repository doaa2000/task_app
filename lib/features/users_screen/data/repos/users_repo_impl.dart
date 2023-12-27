import 'package:dartz/dartz.dart';
import 'package:task_app/core/errors/failures.dart';
import 'package:task_app/core/utils/api_services.dart';
import 'package:task_app/core/utils/end_points.dart';
import 'package:task_app/features/login_screen/data/repos/login_repo_impl.dart';
import 'package:task_app/features/users_screen/data/models/users_model/users_model/users_model.dart';
import 'package:task_app/features/users_screen/data/repos/users_repo.dart';
import 'package:dio/dio.dart';

class UsersRepoImpl extends UsresRepo {
  final ApiService apiService;

  UsersRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, UsersModel>> fetchUsers() async {
    try {
      print("gygygy");
      var data = await apiService.get(
          endPoint: EndPoints.users, authorization: 'Bearer $accessToken');
      UsersModel usersModel = UsersModel.fromJson(data);
      print("cscscsc");
      return right(usersModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
