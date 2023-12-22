import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer ');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer ');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer ');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to api was canceld ');
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected error , please try later!');
      default:
        return ServerFailure('Oops there was an error , Please try later!');
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']);
    } else if (statusCode == 400) {
      return ServerFailure('You requset not found , Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error , Please try later!');
    } else {
      return ServerFailure('Oops there was an error , Please try later!');
    }
  }
}
