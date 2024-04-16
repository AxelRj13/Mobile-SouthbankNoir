import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class ProfilePointRepository {
  Future<DataState<ApiResponseEntity>> getPointHistory();
}
