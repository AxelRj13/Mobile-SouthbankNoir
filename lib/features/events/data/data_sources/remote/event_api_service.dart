import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/network/api_response.dart';

part 'event_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class EventApiService {
  factory EventApiService(Dio dio) = _EventApiService;

  @POST('event/get')
  Future<HttpResponse<ApiResponseModel>> getEvents();

  @POST('event/today/get')
  Future<HttpResponse<ApiResponseModel>> getTodayEvent();

  @POST('event/details')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getEvent(
    @Field('id') String id,
  );
}
