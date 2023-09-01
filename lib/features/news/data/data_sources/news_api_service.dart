import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @POST('news/get')
  Future<HttpResponse<ApiResponseModel>> getNewsList();

  @POST('news/details')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getNews(
    @Field('id') String id,
  );
}
