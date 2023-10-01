import '../../domain/entities/coupon.dart';

class CouponModel extends CouponEntity {
  const CouponModel({
    String? id,
    String? description,
    String? name,
    String? image,
    String? startDate,
    String? endDate,
    String? value,
    String? code,
    String? price,
  }) : super(
          id: id,
          description: description,
          name: name,
          image: image,
          startDate: startDate,
          endDate: endDate,
          value: value,
          code: code,
          price: price,
        );

  factory CouponModel.fromJson(Map<String, dynamic> data) => CouponModel(
        id: data['id'],
        description: data['description'],
        name: data['name'],
        image: data['image'],
        startDate: data['start_date'],
        endDate: data['end_date'],
        value: data['value'],
        code: data['code'],
        price: data['price'],
      );
}
