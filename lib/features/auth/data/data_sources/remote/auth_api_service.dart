import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/network/api_response.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('auth/login')
  @Headers(<String, dynamic>{
    'X-Secret-Token': secret,
  })
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST('auth/register')
  @Headers(<String, dynamic>{
    'X-Secret-Token': secret,
  })
  @FormUrlEncoded()
  Future<HttpResponse<ApiResponseModel>> register(
    @Field('first_name') String firstName,
    @Field('last_name') String lastName,
    @Field('date_of_birth') String dob,
    @Field('city') String city,
    @Field('gender') String gender,
    @Field('email') String email,
    @Field('phone') String phone,
    @Field('password') String password,
    @Field('confirm_password') String confirmPassword,
  );
}
