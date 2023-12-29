import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_app/core/utils/constatnts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:task_app/core/utils/end_points.dart';

import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:get/get.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://uat-api.alfa-sa.co/',
    ),
  );

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Content-Type'] = 'application/json';

        options.headers['x-api-version'] = 'v1';

        String token = await storage.read(key: 'accessToken') ?? '';
        options.headers['Authorization'] = 'Bearer $token';

        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final newAccessToken = await refreshToken();

          _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';

          return handler.resolve(await _dio.fetch(
              error.requestOptions.copyWith(validateStatus: (_) => true)));
        }

        return handler.next(error);
      },
    ));
  }

  Future<String> refreshToken() async {
    try {
      final response = await post(endPoint: EndPoints.refreshToken);

      final newAccessToken = response['payload']['data'][0]['access_token'];

      storage.write(key: 'accessToken', value: newAccessToken);
      return newAccessToken;
    } on Exception catch (error) {
      return error.toString();
    }
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, data, String? authorization}) async {
    var response = await _dio.post(
      endPoint,
      data: data,
    );
    // options: Options(
    //   // headers: {...headers, "Authorization": authorization},
    // ));

    Map<String, dynamic> responseData = {
      'payload': response.data,
      'status': response.statusCode
    };

    return responseData;
  }

  Future<Map<String, dynamic>> get(
      {required String endPoint, String? authorization}) async {
    var response = await _dio.get(
      endPoint,
    );

    return response.data;
  }

  // Future<Map<String, dynamic>> get(
  //     {required String endPoint, String? authorization}) async {
  //   var response = await _dio.get('$baseUrl$endPoint',
  //       options: Options(headers: headerss));

  //   if (response.statusCode == 401) {
  //     if (await storage.containsKey(key: 'refreshToken')) {
  //       print('yall hat new access token ');
  //       await refreshToken();

  //       String newAccessToken = await storage.read(key: 'accessToken') ?? '';
  //       _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';
  //       print("my aces  $newAccessToken");
  //     } else {
  //       Get.to(() => const LoginView());
  //     }
  //   }

  //   return response.data;
  // }

  // Future<Map<String, dynamic>> refreshToken() async {
  //   final refreshToken = await storage.read(key: 'refreshToken');

  //   var response = await post(
  //       endPoint: EndPoints.refreshToken,
  //       authorization: "Bearer $refreshToken");

  //   if (response['status_code'] == 200) {
  //     //   apiService.addToken(response['payload']['data']['accessToken']);
  //     await storage.write(
  //         key: "accessToken", value: response['data']['access_token']);
  //     print('payload ${response['data']['access_token']}');
  //   }
  //   return response;
  // }
}
