import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/reservation_repository.dart';

class CreateReservationUseCase implements UseCase<DataState<ApiResponseEntity>, Map<String, dynamic>> {
  final ReservationRepository _reservationRepository;

  CreateReservationUseCase(this._reservationRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({Map<String, dynamic>? params}) {
    return _reservationRepository.createReservation(payload: params!);
  }
}
