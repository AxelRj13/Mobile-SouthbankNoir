import 'package:equatable/equatable.dart';

class CouponListEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;
  final String? price;
  final String? startDate;
  final String? endDate;

  const CouponListEntity({
    this.id,
    this.name,
    this.image,
    this.price,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        price,
        startDate,
        endDate,
      ];
}
