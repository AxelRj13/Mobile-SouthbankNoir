import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/network/api_response.dart';

part 'popup_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class PopupApiService {
  factory PopupApiService(Dio dio) = _PopupApiService;

  @POST('popupbanner/get')
  Future<HttpResponse<ApiResponseModel>> getPopup();
}
