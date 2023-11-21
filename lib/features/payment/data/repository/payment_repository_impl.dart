import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/payment_repository.dart';
import '../data_sources/payment_api_service.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentApiService _paymentApiService;

  const PaymentRepositoryImpl(this._paymentApiService);

  @override
  Future<DataState<ApiResponseEntity>> getPayment({
    required String bookingId,
  }) async {
    try {
      final httpResponse = await _paymentApiService.getPayment(
        bookingId,
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
  Future<DataState<ApiResponseEntity>> confirmPayment({
    required String bookingId,
  }) async {
    try {
      final httpResponse = await _paymentApiService.confirmPayment(
        bookingId,
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
