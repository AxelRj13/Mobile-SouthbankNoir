import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class LoginRepository {
  Future<DataState<ApiResponseEntity>> login({
    required String email,
    required String password,
  });
}
