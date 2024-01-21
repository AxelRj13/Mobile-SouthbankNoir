import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class ReservationRepository {
  Future<DataState<ApiResponseEntity>> getTables({
    required String storeId,
    required String date,
  });

  Future<DataState<ApiResponseEntity>> getPaymentMethods();

  Future<DataState<ApiResponseEntity>> getReservations();

  Future<DataState<ApiResponseEntity>> createReservation({
    required Map<String, dynamic> payload,
  });

  Future<DataState<ApiResponseEntity>> getReservationDetail({
    required String bookingId,
  });

  Future<DataState<ApiResponseEntity>> applyPromo({
    required String storeId,
    required String subtotal,
    required String code,
  });
}
