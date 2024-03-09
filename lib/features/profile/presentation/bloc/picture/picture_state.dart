import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class ProfilePictureState extends Equatable {
  final File? image;
  final DioException? error;

  const ProfilePictureState({
    this.image,
    this.error,
  });

  @override
  List<Object> get props => [
        image!,
        error!,
      ];
}

class ProfilePictureInitial extends ProfilePictureState {
  const ProfilePictureInitial();
}

class ProfilePictureLoading extends ProfilePictureState {
  const ProfilePictureLoading();
}

class ProfilePictureSet extends ProfilePictureState {
  const ProfilePictureSet({
    required File image,
  }) : super(
          image: image,
        );
}
