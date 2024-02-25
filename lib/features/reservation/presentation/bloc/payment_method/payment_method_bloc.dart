import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../data/models/payment_method_category.dart';
import '../../../domain/usecases/get_payment_method.dart';
import 'payment_method_event.dart';
import 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final GetPaymentMethodsUseCase _getPaymentMethodsUseCase;

  PaymentMethodBloc(this._getPaymentMethodsUseCase) : super(const PaymentMethodLoading()) {
    on<GetPaymentMethods>(onGetPaymentMethods);
  }

  void onGetPaymentMethods(
    GetPaymentMethods event,
    Emitter<PaymentMethodState> emit,
  ) async {
    final dataState = await _getPaymentMethodsUseCase();

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final paymentMethods = (dataState.data!.data as List)
            .map(
              (item) => PaymentMethodCategoryModel.fromJson(item),
            )
            .toList();

        emit(
          PaymentMethodDone(paymentMethods: paymentMethods),
        );
      } else {
        emit(const PaymentMethodNotFound());
      }
    }

    if (dataState is DataFailed) {
      print(dataState.error!.message);
      emit(PaymentMethodError(dataState.error!));
    }
  }
}
