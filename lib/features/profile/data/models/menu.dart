import 'package:flutter/widgets.dart';

import '../../domain/entities/menu.dart';

class ProfileMenuModel extends ProfileMenuEntity {
  const ProfileMenuModel({
    int? id,
    String? label,
    IconData? icon,
    String? route,
  }) : super(
          id: id,
          label: label,
          icon: icon,
          route: route,
        );
}
