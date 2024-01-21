import 'package:equatable/equatable.dart';

class PaymentMethodEntity extends Equatable {
  final String? id;
  final String? name;
  final String? paymentMethod;

  const PaymentMethodEntity({
    this.id,
    this.name,
    this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        paymentMethod,
      ];
}
