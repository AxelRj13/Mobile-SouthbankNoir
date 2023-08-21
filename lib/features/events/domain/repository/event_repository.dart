import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class EventRepository {
  Future<DataState<ApiResponseEntity>> getEvents();
  Future<DataState<ApiResponseEntity>> getTodayEvent();
}
