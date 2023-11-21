import 'package:equatable/equatable.dart';

class ApplyPromoRequest extends Equatable {
  final String storeId;
  final String subtotal;
  final String code;

  const ApplyPromoRequest({
    required this.storeId,
    required this.subtotal,
    required this.code,
  });

  @override
  List<Object?> get props => [
        storeId,
        subtotal,
        code,
      ];
}
