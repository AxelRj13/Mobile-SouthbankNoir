import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';

abstract class PaymentRepository {
  Future<DataState<ApiResponseEntity>> getPayment({
    required String bookingId,
  });

  Future<DataState<ApiResponseEntity>> confirmPayment({
    required String bookingId,
  });
}
