import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/promo_repository.dart';
import '../data_sources/promo_api_service.dart';

class PromoRepositoryImpl implements PromoRepository {
  final PromoApiService _promoApiService;

  PromoRepositoryImpl(this._promoApiService);

  @override
  Future<DataState<ApiResponseModel>> getPromoList() async {
    try {
      final httpResponse = await _promoApiService.getPromoList();

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
  Future<DataState<ApiResponseEntity>> getPromo({
    required String id,
  }) async {
    try {
      final httpResponse = await _promoApiService.getPromo(id);

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
