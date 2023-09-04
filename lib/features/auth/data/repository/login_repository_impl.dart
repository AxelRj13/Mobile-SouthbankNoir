import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/login_repository.dart';
import '../data_sources/auth_api_service.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AuthApiService _authApiService;

  LoginRepositoryImpl(this._authApiService);

  @override
  Future<DataState<ApiResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final httpResponse = await _authApiService.login(
        email,
        password,
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
