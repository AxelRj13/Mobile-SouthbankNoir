import 'package:equatable/equatable.dart';

import 'payment_method.dart';

class PaymentMethodCategoryEntity extends Equatable {
  final String? category;
  final List<PaymentMethodEntity>? paymentMethods;

  const PaymentMethodCategoryEntity({
    this.category,
    this.paymentMethods,
  });

  @override
  List<Object?> get props => [
        category,
        paymentMethods,
      ];
}
