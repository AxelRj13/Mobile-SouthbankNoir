import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class ComplaintRepository {
  Future<DataState<ApiResponseEntity>> getTypes();

  Future<DataState<ApiResponseEntity>> sendComplaint({
    required String type,
    String? date,
    required String store,
    required String description,
  });
}
