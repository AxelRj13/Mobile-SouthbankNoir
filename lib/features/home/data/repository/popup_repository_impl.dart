import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/popup_repository.dart';
import '../data_sources/remote/popup_api_service.dart';

class PopupRepositoryImpl implements PopupRepository {
  final PopupApiService _popupApiService;

  PopupRepositoryImpl(this._popupApiService);

  @override
  Future<DataState<ApiResponseEntity>> getPopup() async {
    try {
      final httpResponse = await _popupApiService.getPopup();

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
