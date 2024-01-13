import '../../domain/entities/outlet.dart';

class OutletModel extends OutletEntity {
  const OutletModel({
    String? name,
    String? address,
    String? androidDirection,
    String? iosDirection,
    String? phone,
    String? image,
  }) : super(
          name: name,
          address: address,
          androidDirection: androidDirection,
          iosDirection: iosDirection,
          phone: phone,
          image: image,
        );

  factory OutletModel.fromJson(Map<String, dynamic> data) => OutletModel(
        name: data['name'],
        address: data['address'],
        androidDirection: data['android_direction'],
        iosDirection: data['ios_direction'],
        phone: data['phone'],
        image: data['image'],
      );
}
