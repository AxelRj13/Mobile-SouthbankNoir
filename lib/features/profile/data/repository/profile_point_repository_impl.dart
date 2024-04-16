import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/profile_point_repository.dart';
import '../data_sources/profile_point_api_service.dart';

class ProfilePointRepositoryImpl implements ProfilePointRepository {
  final ProfilePointApiService _profilePointApiService;

  const ProfilePointRepositoryImpl(this._profilePointApiService);

  @override
  Future<DataState<ApiResponseEntity>> getPointHistory() async {
    try {
      final httpResponse = await _profilePointApiService.getPointHistory();

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
