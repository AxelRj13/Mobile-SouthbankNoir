import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/user.dart';

abstract class AuthState extends Equatable {
  final UserModel? user;
  final DioException? error;

  const AuthState({this.user, this.error});

  @override
  List<Object> get props => [user!, error!];
}

class PrepareUser extends AuthState {
  const PrepareUser();
}

class UserSignedIn extends AuthState {
  const UserSignedIn(UserModel user) : super(user: user);
}

class UserSignedOut extends AuthState {
  const UserSignedOut();
}

class UserNotFound extends AuthState {
  const UserNotFound();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError(DioException error) : super(error: error);
}
