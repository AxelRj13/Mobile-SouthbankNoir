import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? dob,
    String? city,
    String? photo,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          dob: dob,
          city: city,
          photo: photo,
        );

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      phone: data['phone'],
      dob: data['date_of_birth'],
      city: data['city'],
      photo: data['photo'],
    );
  }
}
