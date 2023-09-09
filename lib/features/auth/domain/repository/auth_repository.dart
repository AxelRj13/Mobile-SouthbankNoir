import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class AuthRepository {
  Future<DataState<ApiResponseEntity>> checkEmail({
    required String email,
  });

  Future<DataState<ApiResponseEntity>> login({
    required String email,
    required String? password,
    required bool isViaGoogle,
  });

  Future<DataState<ApiResponseEntity>> register({
    required String firstName,
    required String? lastName,
    required String dob,
    required String city,
    required String gender,
    required String email,
    required String? phone,
    required String password,
    required String confirmPassword,
  });
}
