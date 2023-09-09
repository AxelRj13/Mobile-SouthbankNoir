import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String email;
  final String? password;
  final bool isViaGoogle;

  const LoginRequest({
    required this.email,
    this.password,
    this.isViaGoogle = false,
  });

  @override
  List<Object?> get props => [email, password, isViaGoogle];
}
