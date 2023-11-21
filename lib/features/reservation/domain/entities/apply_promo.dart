import 'package:equatable/equatable.dart';

class ApplyPromo extends Equatable {
  final String? discount;
  final String? payment;

  const ApplyPromo({
    this.discount,
    this.payment,
  });

  @override
  List<Object?> get props => [
        discount,
        payment,
      ];
}
