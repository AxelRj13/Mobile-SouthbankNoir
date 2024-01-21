import '../../domain/entities/payment_method.dart';
import '../../domain/entities/payment_method_category.dart';
import 'payment_method.dart';

class PaymentMethodCategoryModel extends PaymentMethodCategoryEntity {
  const PaymentMethodCategoryModel({
    String? category,
    List<PaymentMethodEntity>? paymentMethods,
  }) : super(
          category: category,
          paymentMethods: paymentMethods,
        );

  factory PaymentMethodCategoryModel.fromJson(Map<String, dynamic> data) => PaymentMethodCategoryModel(
        category: data['category'],
        paymentMethods: data['methods'] != null ? (data['methods'] as List).map((method) => PaymentMethodModel.fromJson(method)).toList() : null,
      );
}
