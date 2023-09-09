import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_sources/profile_api_service.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _profileApiService;

  ProfileRepositoryImpl(this._profileApiService);

  @override
  Future<DataState<ApiResponseEntity>> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? dob,
    String? city,
    String? gender,
    File? file,
  }) async {
    try {
      final httpResponse = await _profileApiService.updateProfile(
        firstName,
        lastName,
        phone,
        dob,
        city,
        gender,
        file,
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
