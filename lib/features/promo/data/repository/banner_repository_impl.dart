import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/banner_repository.dart';
import '../data_sources/remote/banner_api_service.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerApiService _bannerApiService;

  BannerRepositoryImpl(this._bannerApiService);

  @override
  Future<DataState<ApiResponseModel>> getBanners() async {
    try {
      final httpResponse = await _bannerApiService.getBanners();

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
