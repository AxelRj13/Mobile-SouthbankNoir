import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/complaint_repository.dart';
import '../data_sources/remote/complaint_api_service.dart';

class ComplaintRepositoryImpl implements ComplaintRepository {
  final ComplaintApiService _complaintApiService;

  ComplaintRepositoryImpl(this._complaintApiService);

  @override
  Future<DataState<ApiResponseEntity>> getTypes() async {
    try {
      final httpResponse = await _complaintApiService.getTypes();

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
  Future<DataState<ApiResponseEntity>> sendComplaint({
    required String type,
    String? date,
    required String store,
    required String description,
  }) async {
    try {
      final httpResponse = await _complaintApiService.sendComplaint(
        type,
        date ?? '',
        store,
        description,
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
