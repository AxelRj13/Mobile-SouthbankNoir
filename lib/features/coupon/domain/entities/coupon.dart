import 'package:equatable/equatable.dart';

class CouponEntity extends Equatable {
  final String? id;
  final String? description;
  final String? name;
  final String? image;
  final String? startDate;
  final String? endDate;
  final String? value;
  final String? code;
  final String? price;

  const CouponEntity({
    this.id,
    this.description,
    this.name,
    this.image,
    this.startDate,
    this.endDate,
    this.value,
    this.code,
    this.price,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        name,
        image,
        startDate,
        endDate,
        value,
        code,
        price,
      ];
}
