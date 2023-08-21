import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/network/api_response.dart';

part 'banner_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class BannerApiService {
  factory BannerApiService(Dio dio) = _BannerApiService;

  @POST('promo/get-banner')
  // @Headers(<String, dynamic>{
  //   'X-Secret-Token': secret,
  //   'is-mobile': true,
  //   'member-id': 1,
  //   'user-login-name': 'SB Test'
  // })
  Future<HttpResponse<ApiResponseModel>> getBanners();
}
