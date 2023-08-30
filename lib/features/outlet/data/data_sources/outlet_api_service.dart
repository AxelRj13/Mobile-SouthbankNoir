import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'outlet_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class OutletApiService {
  factory OutletApiService(Dio dio) = _OutletApiService;

  @POST('store/details')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> getOutletDetails(
    @Field('store_id') int id,
  );
}
