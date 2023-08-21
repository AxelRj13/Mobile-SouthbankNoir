import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/event_repository.dart';

class GetTodayEventUseCase
    implements UseCase<DataState<ApiResponseEntity>, void> {
  final EventRepository _eventRepository;

  GetTodayEventUseCase(this._eventRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _eventRepository.getTodayEvent();
  }
}
