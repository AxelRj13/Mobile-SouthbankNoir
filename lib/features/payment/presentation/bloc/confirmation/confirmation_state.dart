import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/resources/message_response.dart';
import '../../../data/models/payment.dart';

abstract class ConfirmationPaymentState extends Equatable {
  final PaymentModel? payment;
  final MessageResponse? message;
  final DioException? error;

  const ConfirmationPaymentState({
    this.payment,
    this.message,
    this.error,
  });

  @override
  List<Object> get props => [
        payment!,
        message!,
        error!,
      ];
}

class ConfirmationPaymentInitial extends ConfirmationPaymentState {
  const ConfirmationPaymentInitial();
}

class ConfirmationPaymentLoading extends ConfirmationPaymentState {
  const ConfirmationPaymentLoading();
}

class ConfirmationPaymentDone extends ConfirmationPaymentState {
  const ConfirmationPaymentDone({
    PaymentModel? payment,
    MessageResponse? message,
  }) : super(
          payment: payment,
          message: message,
        );
}

class ConfirmationPaymentError extends ConfirmationPaymentState {
  const ConfirmationPaymentError(
    DioException error,
  ) : super(
          error: error,
        );
}
