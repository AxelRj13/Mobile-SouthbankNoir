import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/invoice.dart';
import '../../../domain/usecases/get_payment.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentUseCase _getPaymentUseCase;

  PaymentBloc(
    this._getPaymentUseCase,
  ) : super(const PaymentInitial()) {
    on<GetPayment>(onGetPayment);
  }

  void onGetPayment(
    GetPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());

    final dataState = await _getPaymentUseCase(
      params: event.bookingId,
    );

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final payment = InvoiceModel.fromJson(
          dataState.data!.data,
        );

        emit(
          PaymentDone(
            payment: payment,
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(PaymentError(dataState.error!));
    }
  }
}
