import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio _dio;
  static String baseUrl = 'https://uat-api.alfa-sa.co/';

  static var headers = {
    'x-api-version': 'v1',
    'Content-Type': 'application/json'
  };

  static var headerss = {'Content-Type': 'application/json'};
  ApiService({required Dio dio}) : _dio = dio;

  void addToken(String token) {
    if (headers.containsKey(HttpHeaders.authorizationHeader)) {
      headers.remove(HttpHeaders.authorizationHeader);
    }
    headers.putIfAbsent(HttpHeaders.authorizationHeader, () => "Bearer $token");
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, data, String? authorization}) async {
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

  Future<Map<String, dynamic>> get(
      {required String endPoint, String? authorization}) async {
    var response = await _dio.get('$baseUrl$endPoint',
        options:
            Options(headers: {...headers, "Authorization": authorization}));

    return response.data;
  }
}
