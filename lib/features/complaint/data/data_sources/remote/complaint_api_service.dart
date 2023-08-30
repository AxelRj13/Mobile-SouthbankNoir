import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/network/api_response.dart';

part 'complaint_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class ComplaintApiService {
  factory ComplaintApiService(Dio dio) = _ComplaintApiService;

  @POST('complaint/get')
  Future<HttpResponse<ApiResponseModel>> getTypes();

  @POST('complaint/create')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> sendComplaint(
    @Field('type') String type,
    @Field('date') String? date,
    @Field('store') String store,
    @Field('description') String description,
  );
}
