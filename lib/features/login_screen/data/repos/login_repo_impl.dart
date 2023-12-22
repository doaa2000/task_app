import 'package:dartz/dartz.dart';
import 'package:task_app/core/errors/failure.dart';
import 'package:task_app/core/utils/api_services.dart';
import 'package:task_app/core/utils/end_points.dart';
import 'package:task_app/features/login_screen/data/models/login_model/login_model/login_model.dart';
import 'package:task_app/features/login_screen/data/repos/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;

  LoginRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, LoginModel>> userLogin(
      {required String email, required String password}) async {
    try {
      var data = await apiService.post(endPoint: EndPoints.login, data: {
        'email': email,
        'password': password,
      });
      LoginModel loginModel = LoginModel.fromJson(data);

      return right(loginModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
