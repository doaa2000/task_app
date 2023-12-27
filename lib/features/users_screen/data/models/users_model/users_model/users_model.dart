import 'data.dart';

class UsersModel {
  int? statusCode;
  Data? data;
  bool? success;
  dynamic error;

  UsersModel({this.statusCode, this.data, this.success, this.error});

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        statusCode: json['status_code'] as int?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        success: json['success'] as bool?,
        error: json['error'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'data': data?.toJson(),
        'success': success,
        'error': error,
      };
}
