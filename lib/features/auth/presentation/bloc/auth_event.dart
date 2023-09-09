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

class Login extends AuthEvent {
  final String email;
  final String? password;
  final bool isViaGoogle;

  const Login({
    required this.email,
    this.password,
    this.isViaGoogle = false,
  });
}

class LoginGoogle extends AuthEvent {
  final String id;
  final String email;
  final String? name;

  const LoginGoogle({
    required this.id,
    required this.email,
    this.name,
  });
}

class Logout extends AuthEvent {}

class CheckSignInStatus extends AuthEvent {}
