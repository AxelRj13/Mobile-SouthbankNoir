import 'package:southbank/features/promo/domain/entities/promo.dart';

class PromoModel extends PromoEntity {
  const PromoModel({
    String? title,
    String? description,
    String? promoDate,
    String? image,
    String? minimumSpend,
  }) : super(
          title: title,
          description: description,
          promoDate: promoDate,
          image: image,
          minimumSpend: minimumSpend,
        );

  factory PromoModel.fromJson(Map<String, dynamic> data) => PromoModel(
        title: data['title'],
        description: data['description'],
        promoDate: data['promo_date'],
        image: data['image'],
        minimumSpend: data['minimum_spend'],
      );
}
