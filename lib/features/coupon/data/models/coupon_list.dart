import '../../domain/entities/coupon_list.dart';

class CouponListModel extends CouponListEntity {
  const CouponListModel({
    String? id,
    String? name,
    String? image,
    String? price,
    String? startDate,
    String? endDate,
  }) : super(
          id: id,
          name: name,
          image: image,
          price: price,
          startDate: startDate,
          endDate: endDate,
        );

  factory CouponListModel.fromJson(Map<String, dynamic> data) =>
      CouponListModel(
        id: data['id'],
        name: data['name'],
        image: data['image'],
        price: data['price'],
        startDate: data['start_date'],
        endDate: data['end_date'],
      );
}
