import 'package:equatable/equatable.dart';

class ApiResponseEntity extends Equatable {
  final int status;
  final String? message;
  final dynamic data;
  final String? token;

  const ApiResponseEntity({
    required this.status,
    this.message,
    required this.data,
    required this.token,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        data,
        token,
      ];
}

class ApiResponseModel extends ApiResponseEntity {
  const ApiResponseModel({
    required int status,
    String? message,
    required dynamic data,
    String? token,
  }) : super(
          status: status,
          message: message,
          data: data,
          token: token,
        );

  factory ApiResponseModel.fromJson(Map<String, dynamic> data) {
    return ApiResponseModel(
      status: data['status'],
      message: data['message'],
      data: data['data'],
      token: data['token'],
    );
  }
}
