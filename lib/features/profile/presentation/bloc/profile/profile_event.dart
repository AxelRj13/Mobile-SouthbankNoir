import 'dart:io';

abstract class ProfileEvent {
  const ProfileEvent();
}

class UpdateProfile extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String? email;
  final String phone;
  final String dob;
  final String city;
  final File? image;

  const UpdateProfile({
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phone,
    required this.dob,
    required this.city,
    this.image,
  });
}

class CheckProfile extends ProfileEvent {}
