import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/table_request.dart';
import '../repository/reservation_repository.dart';

class GetTablesUseCase implements UseCase<DataState<ApiResponseEntity>, TableRequest> {
  final ReservationRepository _reservationRepository;

  GetTablesUseCase(this._reservationRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({TableRequest? params}) {
    final tableRequest = params!;

    return _reservationRepository.getTables(
      storeId: tableRequest.storeId,
      date: tableRequest.date,
    );
  }
}
