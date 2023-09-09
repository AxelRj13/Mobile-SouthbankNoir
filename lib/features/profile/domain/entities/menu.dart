import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ProfileMenuEntity extends Equatable {
  final int? id;
  final String? label;
  final IconData? icon;
  final String? route;

  const ProfileMenuEntity({this.id, this.label, this.icon, this.route});

  @override
  List<Object?> get props => [id, label, icon, route];
}
