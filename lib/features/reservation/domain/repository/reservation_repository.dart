import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class ReservationRepository {
  Future<DataState<ApiResponseEntity>> getTables({
    required String storeId,
    required String date,
  });

  Future<DataState<ApiResponseEntity>> getReservationDetail({
    required String bookingId,
  });

  Future<DataState<ApiResponseEntity>> createReservation({
    required Map<String, dynamic> payload,
  });

  Future<DataState<ApiResponseEntity>> applyPromo({
    required String bookingId,
    required String code,
  });
}
