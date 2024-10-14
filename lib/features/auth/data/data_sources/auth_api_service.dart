import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_response.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('auth/login')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> login(
    @Field('email') String email,
    @Field('password') String? password,
    @Field('is_via_google') bool isViaGoogle,
  );

  @POST('auth/register')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> register(
    @Field('first_name') String firstName,
    @Field('last_name') String? lastName,
    @Field('date_of_birth') String dob,
    @Field('city') String city,
    @Field('email') String? email,
    @Field('phone') String phone,
    @Field('password') String password,
    @Field('confirm_password') String confirmPassword,
  );

  @POST('auth/check-email')
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> checkEmail(
    @Field('email') String email,
  );
}
