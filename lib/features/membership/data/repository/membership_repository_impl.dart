import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/membership_repository.dart';
import '../data_sources/membership_api_service.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final MembershipApiService _membershipApiService;

  MembershipRepositoryImpl(this._membershipApiService);

  @override
  Future<DataState<ApiResponseEntity>> getMembership() async {
    try {
      final httpResponse = await _membershipApiService.getMembership();

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
