import '../../domain/entities/payment_method.dart';

class PaymentMethodModel extends PaymentMethodEntity {
  const PaymentMethodModel({
    String? id,
    String? name,
    String? paymentMethod,
  }) : super(
          id: id,
          name: name,
          paymentMethod: paymentMethod,
        );

  factory PaymentMethodModel.fromJson(Map<String, dynamic> data) => PaymentMethodModel(
        id: data['id'],
        name: data['name'],
        paymentMethod: data['payment_type'],
      );
}
