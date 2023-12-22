import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  final baseUrl = 'https://uat-api.alfa-sa.co/api/auth/';

  ApiService(this._dio);

  var headers = {'x-api-version': 'v1', 'Content-Type': 'application/json'};

  Future<Map<String, dynamic>> post({required String endPoint, data}) async {
    final Response<dynamic> response = await _dio.post('$baseUrl$endPoint',
        data: data,
        options: Options(
          headers: headers,
        ));
    print("api respons :  $response");
    return response.data;
  }
}
