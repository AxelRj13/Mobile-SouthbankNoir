import 'package:equatable/equatable.dart';

class MenuEntity extends Equatable {
  final int? id;
  final String? label;
  final String? image;
  final String? route;

  const MenuEntity({
    this.id,
    this.label,
    this.image,
    this.route,
  });

  @override
  List<Object?> get props => [
        id,
        label,
        image,
        route,
      ];
}
