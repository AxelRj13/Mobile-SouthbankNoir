import 'dart:io';

abstract class ProfileEvent {
  const ProfileEvent();
}

class SetPhoto extends ProfileEvent {
  final File image;

  const SetPhoto({required this.image});
}

class UpdateProfile extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String dob;
  final String city;
  final String gender;
  final String phone;

  const UpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.city,
    required this.gender,
    required this.phone,
  });
}

class CheckProfile extends ProfileEvent {}
