import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/resources/message_response.dart';
import '../../data/models/user.dart';

abstract class AuthState extends Equatable {
  final MessageResponse? message;
  final UserModel? user;
  final DioException? error;

  const AuthState({this.message, this.user, this.error});

  @override
  List<Object> get props => [message!, user!, error!];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class UserSignedIn extends AuthState {
  const UserSignedIn(UserModel user) : super(user: user);
}

class UserSignedOut extends AuthState {
  const UserSignedOut();
}

class AuthMessage extends AuthState {
  const AuthMessage(MessageResponse message) : super(message: message);
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError(DioException error) : super(error: error);
}
