import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class OutletRepository {
  Future<DataState<ApiResponseEntity>> getOutletDetails();
}
