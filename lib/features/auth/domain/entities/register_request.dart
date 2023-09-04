import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String firstName;
  final String lastName;
  final String dob;
  final String city;
  final String gender;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  const RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.city,
    required this.gender,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [];
}
