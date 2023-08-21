import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? phone;
  final String? photo;

  const UserEntity({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phone,
        photo,
      ];
}
