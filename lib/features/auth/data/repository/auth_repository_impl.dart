import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<ApiResponseEntity>> checkEmail({
    required String email,
  }) async {
    try {
      final httpResponse = await _authApiService.checkEmail(email);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ApiResponseEntity>> login({
    required String email,
    required String? password,
    required bool isViaGoogle,
  }) async {
    try {
      final httpResponse = await _authApiService.login(
        email,
        password,
        isViaGoogle,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ApiResponseEntity>> register({
    required String firstName,
    required String? lastName,
    required String dob,
    required String city,
    required String gender,
    required String email,
    required String? phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final httpResponse = await _authApiService.register(
        firstName,
        lastName,
        dob,
        city,
        gender,
        email,
        phone,
        password,
        confirmPassword,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
