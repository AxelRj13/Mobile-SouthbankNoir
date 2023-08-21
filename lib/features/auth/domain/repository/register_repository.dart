import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class RegisterRepository {
  Future<DataState<ApiResponseEntity>> register({
    required String firstName,
    required String lastName,
    required String dob,
    required String city,
    required String gender,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  });
}
