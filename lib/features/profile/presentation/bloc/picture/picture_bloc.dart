import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'picture_event.dart';
import 'picture_state.dart';

class ProfilePictureBloc extends Bloc<ProfilePictureEvent, ProfilePictureState> {
  File? image;

  ProfilePictureBloc() : super(const ProfilePictureInitial()) {
    on<SetPhoto>(onSetPhoto);
  }

  void onSetPhoto(
    SetPhoto event,
    Emitter<ProfilePictureState> emit,
  ) {
    emit(const ProfilePictureLoading());

    image = event.image;

    emit(ProfilePictureSet(image: image!));
  }
}
