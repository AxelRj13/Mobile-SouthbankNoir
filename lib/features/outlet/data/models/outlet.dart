import '../../domain/entities/outlet.dart';

class OutletModel extends OutletEntity {
  const OutletModel({
    String? name,
    String? address,
    String? direction,
    String? phone,
    String? image,
  }) : super(
          name: name,
          address: address,
          direction: direction,
          phone: phone,
          image: image,
        );

  factory OutletModel.fromJson(Map<String, dynamic> data) => OutletModel(
        name: data['name'],
        address: data['address'],
        direction: data['direction'],
        phone: data['phone'],
        image: data['image'],
      );
}
