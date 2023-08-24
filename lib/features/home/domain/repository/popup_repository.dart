import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class PopupRepository {
  Future<DataState<ApiResponseEntity>> getPopup();
}
