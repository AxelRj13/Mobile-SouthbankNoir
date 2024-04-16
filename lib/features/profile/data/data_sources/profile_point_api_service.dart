import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'profile_point_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class ProfilePointApiService {
  factory ProfilePointApiService(Dio dio) = _ProfilePointApiService;

  @POST('profile/point-history')
  Future<HttpResponse<ApiResponseModel>> getPointHistory();
}
