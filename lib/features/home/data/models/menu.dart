import '../../domain/entities/menu.dart';

class MenuModel extends MenuEntity {
  const MenuModel({
    int? id,
    String? label,
    String? image,
    String? route,
  }) : super(
          id: id,
          label: label,
          image: image,
          route: route,
        );
}
