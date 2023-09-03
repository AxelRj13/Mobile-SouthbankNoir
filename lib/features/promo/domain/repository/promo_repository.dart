import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class PromoRepository {
  Future<DataState<ApiResponseEntity>> getPromoList();

  Future<DataState<ApiResponseEntity>> getPromo({
    required String id,
  });
}
