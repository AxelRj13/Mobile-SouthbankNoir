import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/message_response.dart';
import '../../../data/models/payment.dart';
import '../../../domain/usecases/confirm_payment.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';

class ConfirmationPaymentBloc extends Bloc<ConfirmationPaymentEvent, ConfirmationPaymentState> {
  final ConfirmPaymentUseCase _confirmPaymentUseCase;

  ConfirmationPaymentBloc(
    this._confirmPaymentUseCase,
  ) : super(const ConfirmationPaymentInitial()) {
    on<ConfirmPayment>(onConfirmPayment);
  }

  void onConfirmPayment(
    ConfirmPayment event,
    Emitter<ConfirmationPaymentState> emit,
  ) async {
    emit(const ConfirmationPaymentLoading());

    final dataState = await _confirmPaymentUseCase(
      params: event.bookingId,
    );

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      bool responseStatus = status == 1;
      String responseTitle = 'Oppss...';
      String responseMessage = dataState.data!.message!;

      if (status == 1) {
        responseTitle = 'Payment success!';
      }

      final messageResponse = MessageResponse(
        status: responseStatus,
        title: responseTitle,
        message: responseMessage,
      );

      if (status == 1) {
        final payment = PaymentModel.fromJson(dataState.data!.data);

        emit(
          ConfirmationPaymentDone(
            message: messageResponse,
            payment: payment,
          ),
        );
      } else {
        emit(
          ConfirmationPaymentDone(
            message: messageResponse,
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(ConfirmationPaymentError(dataState.error!));
    }
  }
}
