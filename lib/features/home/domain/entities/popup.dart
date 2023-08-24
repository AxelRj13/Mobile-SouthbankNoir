import 'package:equatable/equatable.dart';

class PopupEntity extends Equatable {
  final String? name;
  final String? image;

  const PopupEntity({
    this.name,
    this.image,
  });

  @override
  List<Object?> get props => [
        name,
        image,
      ];
}
