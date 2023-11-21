import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'payment_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class PaymentApiService {
  factory PaymentApiService(Dio dio) = _PaymentApiService;

  @POST('booking/payment')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getPayment(
    @Field('booking_id') String bookingId,
  );

  @POST('booking/confirm/payment')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> confirmPayment(
    @Field('booking_id') String bookingId,
  );
}
