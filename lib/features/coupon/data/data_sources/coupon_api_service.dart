import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'coupon_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CouponApiService {
  factory CouponApiService(Dio dio) = _CouponApiService;

  @POST('coupon/get')
  Future<HttpResponse<ApiResponseModel>> getCoupons();

  @POST('coupon/details')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getCouponDetail(
    @Field('id') String id,
  );

  @POST('coupon/buy-coupon')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> buyCoupon(
    @Field('coupon_id') String couponId,
  );

  @POST('my-coupon/details')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getMyCouponDetail(
    @Field('id') String id,
  );
}
