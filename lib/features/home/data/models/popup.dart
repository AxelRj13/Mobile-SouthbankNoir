import '../../domain/entities/popup.dart';

class PopupModel extends PopupEntity {
  const PopupModel({
    String? name,
    String? image,
  }) : super(
          name: name,
          image: image,
        );

  factory PopupModel.fromJson(Map<String, dynamic> data) => PopupModel(
        name: data['name'],
        image: data['image'],
      );
}
