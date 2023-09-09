import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class MembershipRepository {
  Future<DataState<ApiResponseEntity>> getMembership();
}
