import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/reservation_repository.dart';

class GetPaymentMethodsUseCase implements UseCase<DataState<ApiResponseEntity>, void> {
  final ReservationRepository _reservationRepository;

  GetPaymentMethodsUseCase(this._reservationRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _reservationRepository.getPaymentMethods();
  }
}
