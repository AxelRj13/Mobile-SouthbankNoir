import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/reservation_repository.dart';

class GetReservationDetailUseCase implements UseCase<DataState<ApiResponseEntity>, String> {
  final ReservationRepository _reservationRepository;

  GetReservationDetailUseCase(this._reservationRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({String? params}) {
    return _reservationRepository.getReservationDetail(bookingId: params!);
  }
}
