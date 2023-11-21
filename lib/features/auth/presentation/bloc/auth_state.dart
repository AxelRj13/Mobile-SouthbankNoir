import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/resources/message_response.dart';
import '../../data/models/user.dart';

abstract class AuthState extends Equatable {
  final MessageResponse? message;
  final bool? alreadyRegistered;
  final UserModel? user;
  final DioException? error;

  const AuthState({
    this.message,
    this.alreadyRegistered,
    this.user,
    this.error,
  });

  @override
  List<Object> get props => [
        message!,
        alreadyRegistered!,
        user!,
        error!,
      ];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthGoogleLoading extends AuthState {
  const AuthGoogleLoading();
}

class AuthError extends AuthState {
  const AuthError(
    DioException error,
  ) : super(
          error: error,
        );
}

class AuthMessage extends AuthState {
  const AuthMessage({
    required MessageResponse message,
  }) : super(
          message: message,
        );
}

class AuthCheckEmail extends AuthState {
  const AuthCheckEmail({
    required bool alreadyRegistered,
  }) : super(
          alreadyRegistered: alreadyRegistered,
        );
}

class AuthUserLogin extends AuthState {
  const AuthUserLogin({
    required UserModel user,
  }) : super(
          user: user,
        );
}

class AuthUserLogout extends AuthState {
  const AuthUserLogout();
}
