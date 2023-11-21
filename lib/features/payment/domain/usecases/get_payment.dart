import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/payment_repository.dart';

class GetPaymentUseCase implements UseCase<DataState<ApiResponseEntity>, String> {
  final PaymentRepository _paymentRepository;

  GetPaymentUseCase(this._paymentRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({String? params}) {
    return _paymentRepository.getPayment(bookingId: params!);
  }
}
