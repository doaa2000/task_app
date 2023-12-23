import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiService {
  final Dio _dio = Dio();
  static String baseUrl = 'https://uat-api.alfa-sa.co/api/auth/';
  var storage = const FlutterSecureStorage();
  static var headers = {
    'x-api-version': 'v1',
    'Content-Type': 'application/json'
  };

  Future<Map<String, dynamic>> post(
      {required String endPoint, data, String? authorization}) async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (hasInternet) {
      var response = await _dio.post('$baseUrl$endPoint',
          data: data,
          options: Options(
            headers: {...headers, "Authorization": authorization},
          ));

      Map<String, dynamic> responseData = {
        'payload': response.data,
        'status': response.statusCode
      };

      return responseData;
    }
    throw ('No Internet');
  }
}
