import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/apply_promo_request.dart';
import '../repository/reservation_repository.dart';

class ApplyPromoUseCase implements UseCase<DataState<ApiResponseEntity>, ApplyPromoRequest> {
  final ReservationRepository _reservationRepository;

  ApplyPromoUseCase(this._reservationRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({ApplyPromoRequest? params}) {
    final applyPromoRequest = params!;

    return _reservationRepository.applyPromo(
      storeId: applyPromoRequest.storeId,
      subtotal: applyPromoRequest.subtotal,
      code: applyPromoRequest.code,
    );
  }
}
