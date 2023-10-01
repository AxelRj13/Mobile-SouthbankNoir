import 'package:flutter/widgets.dart';

import '../../domain/entities/menu.dart';

class ProfileMenuRouteModel extends ProfileMenuRouteEntity {
  const ProfileMenuRouteModel({
    String? route,
    Map<String, String>? parameter,
  }) : super(
          route: route,
          parameter: parameter,
        );
}

class ProfileMenuModel extends ProfileMenuEntity {
  const ProfileMenuModel({
    int? id,
    String? label,
    IconData? icon,
    ProfileMenuRouteModel? route,
  }) : super(
          id: id,
          label: label,
          icon: icon,
          route: route,
        );
}
