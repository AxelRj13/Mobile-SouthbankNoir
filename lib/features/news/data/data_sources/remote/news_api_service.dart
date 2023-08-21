import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/network/api_response.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @POST('news/get')
  // @Headers(<String, dynamic>{
  //   'X-Secret-Token': secret,
  //   'is-mobile': true,
  //   'member-id': 1,
  //   'user-login-name': 'SB Test'
  // })
  Future<HttpResponse<ApiResponseModel>> getNews();
}
