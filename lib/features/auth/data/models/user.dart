import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? photo,
  }) : super(
          id: id,
          email: email,
          name: name,
          phone: phone,
          photo: photo,
        );

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      email: data['email'],
      name: data['name'],
      phone: data['phone'],
      photo: data['photo'],
    );
  }
}
