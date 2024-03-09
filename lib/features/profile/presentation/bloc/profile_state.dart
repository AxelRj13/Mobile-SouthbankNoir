import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/resources/message_response.dart';
import '../../../auth/data/models/user.dart';

abstract class ProfileState extends Equatable {
  final MessageResponse? message;
  final UserModel? user;
  final DioException? error;

  const ProfileState({
    this.message,
    this.user,
    this.error,
  });

  @override
  List<Object> get props => [
        message!,
        user!,
        error!,
      ];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileDone extends ProfileState {
  const ProfileDone({
    required UserModel user,
  }) : super(
          user: user,
        );
}

class ProfileUpdateMessage extends ProfileState {
  const ProfileUpdateMessage({
    required MessageResponse message,
  }) : super(
          message: message,
        );
}

class ProfileUpdateError extends ProfileState {
  const ProfileUpdateError(
    DioException error,
  ) : super(
          error: error,
        );
}
