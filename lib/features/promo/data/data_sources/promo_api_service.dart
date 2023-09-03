import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'promo_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class PromoApiService {
  factory PromoApiService(Dio dio) = _PromoApiService;

  @POST('promo/get')
  Future<HttpResponse<ApiResponseModel>> getPromoList();

  @POST('promo/details')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getPromo(
    @Field('id') String id,
  );
}
