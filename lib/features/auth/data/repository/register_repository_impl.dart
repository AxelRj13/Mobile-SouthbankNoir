import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/register_repository.dart';
import '../data_sources/remote/auth_api_service.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final AuthApiService _authApiService;

  RegisterRepositoryImpl(this._authApiService);

  @override
  Future<DataState<ApiResponseEntity>> register(
      {required String firstName,
      required String lastName,
      required String dob,
      required String city,
      required String gender,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword}) async {
    try {
      print('Repository');
      print({
        'firstname': firstName,
        'lastname': lastName,
        'dob': dob,
        'city': city,
        'gender': gender,
        'email': email,
        'phone': phone,
        'password': password,
      });
      final httpResponse = await _authApiService.register(firstName, lastName,
          dob, city, gender, email, phone, password, confirmPassword);

      print('Response');
      print(httpResponse);

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
