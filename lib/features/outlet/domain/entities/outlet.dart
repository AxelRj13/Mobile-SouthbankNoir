import 'package:equatable/equatable.dart';

class OutletEntity extends Equatable {
  final String? name;
  final String? address;
  final String? androidDirection;
  final String? iosDirection;
  final String? phone;
  final String? image;

  const OutletEntity({
    this.name,
    this.address,
    this.androidDirection,
    this.iosDirection,
    this.phone,
    this.image,
  });

  @override
  List<Object?> get props => [
        name,
        address,
        androidDirection,
        iosDirection,
        phone,
        image,
      ];
}
