import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/resources/message_response.dart';
import '../../../data/models/invoice.dart';

abstract class PaymentState extends Equatable {
  final String? bookingId;
  final InvoiceModel? payment;
  final MessageResponse? message;
  final DioException? error;

  const PaymentState({
    this.bookingId,
    this.payment,
    this.message,
    this.error,
  });

  @override
  List<Object> get props => [
        bookingId!,
        payment!,
        message!,
        error!,
      ];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentDone extends PaymentState {
  const PaymentDone({
    required InvoiceModel payment,
  }) : super(
          payment: payment,
        );
}

class PaymentExpired extends PaymentState {
  const PaymentExpired({
    required MessageResponse message,
  }) : super(
          message: message,
        );
}

class PaymentError extends PaymentState {
  const PaymentError(
    DioException error,
  ) : super(
          error: error,
        );
}
