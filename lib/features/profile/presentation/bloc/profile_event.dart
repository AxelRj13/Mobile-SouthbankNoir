import 'dart:io';

abstract class ProfileEvent {
  const ProfileEvent();
}

class UpdateProfile extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String dob;
  final String city;
  final String gender;
  final String phone;
  final File? image;

  const UpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.city,
    required this.gender,
    required this.phone,
    this.image,
  });
}

class CheckProfile extends ProfileEvent {}
