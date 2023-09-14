import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'membership_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class MembershipApiService {
  factory MembershipApiService(Dio dio) = _MembershipApiService;

  @POST('membership/details')
  Future<HttpResponse<ApiResponseModel>> getMembership();
}
