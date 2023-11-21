import '../../domain/entities/apply_promo.dart';

class ApplyPromoModel extends ApplyPromo {
  const ApplyPromoModel({
    String? discount,
    String? payment,
  }) : super(
          discount: discount,
          payment: payment,
        );

  factory ApplyPromoModel.fromJson(Map<String, dynamic> data) => ApplyPromoModel(
        discount: data['discount'],
        payment: data['payment'],
      );
}
