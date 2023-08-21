abstract class AuthEvent {
  const AuthEvent();
}

class Register extends AuthEvent {
  final String firstName;
  final String lastName;
  final String dob;
  final String city;
  final String gender;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  const Register({
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
}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  const SignIn({
    required this.email,
    required this.password,
  });
}

class SignOut extends AuthEvent {}

class CheckSignInStatus extends AuthEvent {}
