import 'dart:io';

import 'package:equatable/equatable.dart';

class ProfileRequest extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? dob;
  final String? city;
  final String? gender;
  final File? file;

  const ProfileRequest({
    this.firstName,
    this.lastName,
    this.phone,
    this.dob,
    this.city,
    this.gender,
    this.file,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phone,
        dob,
        city,
        gender,
        file,
      ];
}
