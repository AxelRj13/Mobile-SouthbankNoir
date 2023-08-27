import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/outlet_repository.dart';
import '../data_sources/outlet_api_service.dart';

class OutletRepositoryImpl implements OutletRepository {
  final OutletApiService _outletApiService;

  OutletRepositoryImpl(this._outletApiService);

  @override
  Future<DataState<ApiResponseEntity>> getOutletDetails() async {
    try {
      final httpResponse = await _outletApiService.getOutletDetails(1);

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
