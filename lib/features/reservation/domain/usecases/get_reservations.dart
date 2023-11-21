import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/reservation_repository.dart';

class GetReservationsUseCase implements UseCase<DataState<ApiResponseEntity>, void> {
  final ReservationRepository _reservationRepository;

  GetReservationsUseCase(this._reservationRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _reservationRepository.getReservations();
  }
}
