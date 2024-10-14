import 'dart:io';

import 'package:equatable/equatable.dart';

class ProfileRequest extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? dob;
  final String? city;
  final File? file;

  const ProfileRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dob,
    this.city,
    this.file,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phone,
        dob,
        city,
        file,
      ];
}
