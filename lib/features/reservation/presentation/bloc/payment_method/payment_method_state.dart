import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/payment_method_category.dart';

abstract class PaymentMethodState extends Equatable {
  final List<PaymentMethodCategoryModel>? paymentMethods;
  final DioException? error;

  const PaymentMethodState({this.paymentMethods, this.error});

  @override
  List<Object> get props => [paymentMethods!, error!];
}

class PaymentMethodLoading extends PaymentMethodState {
  const PaymentMethodLoading();
}

class PaymentMethodDone extends PaymentMethodState {
  const PaymentMethodDone(List<PaymentMethodCategoryModel> paymentMethods) : super(paymentMethods: paymentMethods);
}

class PaymentMethodError extends PaymentMethodState {
  const PaymentMethodError(DioException error) : super(error: error);
}
