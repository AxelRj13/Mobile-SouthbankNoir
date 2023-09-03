import '../../domain/entities/promo_list.dart';

class PromoListModel extends PromoListEntity {
  const PromoListModel({
    String? id,
    String? title,
    String? promoDate,
    String? image,
    String? minimumSpend,
  }) : super(
          id: id,
          title: title,
          promoDate: promoDate,
          image: image,
          minimumSpend: minimumSpend,
        );

  factory PromoListModel.fromJson(Map<String, dynamic> data) => PromoListModel(
        id: data['id'],
        title: data['title'],
        promoDate: data['promo_date'],
        image: data['image'],
        minimumSpend: data['minimum_spend'],
      );
}
