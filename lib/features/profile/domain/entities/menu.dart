import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ProfileMenuRouteEntity extends Equatable {
  final String? route;
  final Map<String, String>? parameter;

  const ProfileMenuRouteEntity({this.route, this.parameter});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProfileMenuEntity extends Equatable {
  final int? id;
  final String? label;
  final IconData? icon;
  final ProfileMenuRouteEntity? route;

  const ProfileMenuEntity({this.id, this.label, this.icon, this.route});

  @override
  List<Object?> get props => [id, label, icon, route];
}
