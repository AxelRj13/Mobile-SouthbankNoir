import 'package:equatable/equatable.dart';

class OutletEntity extends Equatable {
  final String? name;
  final String? address;
  final String? direction;
  final String? phone;
  final String? image;

  const OutletEntity({
    this.name,
    this.address,
    this.direction,
    this.phone,
    this.image,
  });

  @override
  List<Object?> get props => [
        name,
        address,
        direction,
        phone,
        image,
      ];
}
