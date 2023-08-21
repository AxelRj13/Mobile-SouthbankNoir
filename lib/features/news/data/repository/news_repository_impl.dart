import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/news_repository.dart';
import '../data_sources/remote/news_api_service.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService _newsApiService;

  NewsRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<ApiResponseModel>> getNews() async {
    try {
      final httpResponse = await _newsApiService.getNews();

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
