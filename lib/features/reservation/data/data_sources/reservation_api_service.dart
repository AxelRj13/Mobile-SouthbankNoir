import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'reservation_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class ReservationApiService {
  factory ReservationApiService(Dio dio) = _ReservationApiService;

  @POST('table/get')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getTables(
    @Field('store_id') String storeId,
    @Field('date') String date,
  );

  @POST('booking/details')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getReservationDetail(
    @Field('booking_id') String bookingId,
  );

  @POST('booking/create')
  Future<HttpResponse<ApiResponseModel>> createReservation(
    @Body() Map<String, dynamic> payload,
  );

  @POST('booking/apply-promo')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> applyPromo(
    @Field('booking_id') String bookingId,
    @Field('code') String code,
  );
}
