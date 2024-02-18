import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/message_response.dart';
import '../../../../injection_container.dart';
import '../../../auth/data/models/user.dart';
import '../../domain/entities/profile_request.dart';
import '../../domain/usecases/update_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  File? image;

  ProfileBloc(this._updateProfileUseCase) : super(const ProfileInitial()) {
    on<SetPhoto>(onSetPhoto);
    on<UpdateProfile>(onUpdateProfile);
    on<CheckProfile>(onCheckProfile);
  }

  void onSetPhoto(
    SetPhoto event,
    Emitter<ProfileState> emit,
  ) {
    emit(const ProfileLoading());

    image = event.image;

    emit(ProfilePhotoSet(image!));
  }

  void onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final prefs = getIt.get<SharedPreferences>();

    print({
      'firstName': event.firstName,
      'lastName': event.lastName,
      'phone': event.phone,
      'dob': event.dob,
      'city': event.city,
      'gender': event.gender,
      'file': image,
    });

    final profileRequest = ProfileRequest(
      firstName: event.firstName,
      lastName: event.lastName,
      phone: event.phone,
      dob: event.dob,
      city: event.city,
      gender: event.gender,
      file: image,
    );

    final dataState = await _updateProfileUseCase(params: profileRequest);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      bool responseStatus = status == 1;
      String responseTitle = 'Oppss...';
      String responseMessage = 'Failed to update profile';

      if (status == 1) {
        final token = dataState.data!.token;
        final user = UserModel.fromJson(dataState.data!.data);

        print(dataState.data!.data);

        prefs.setString('token', token!);
        prefs.setString('id', user.id!);
        prefs.setString('firstName', user.firstName!);
        prefs.setString('lastName', user.lastName!);
        prefs.setString('email', user.email!);
        prefs.setString('phone', user.phone!);
        prefs.setString('dob', user.dob!);
        prefs.setString('gender', user.gender!);
        prefs.setString('city', user.city!);
        prefs.setString('photo', user.photo!);

        responseTitle = 'Success';
        responseMessage = dataState.data!.message!;
      }

      final messageResponse = MessageResponse(
        status: responseStatus,
        title: responseTitle,
        message: responseMessage,
      );

      emit(ProfileUpdateMessage(messageResponse));
    }

    if (dataState is DataFailed) {
      emit(ProfileUpdateError(dataState.error!));
    }
  }

  void onCheckProfile(
    CheckProfile event,
    Emitter<ProfileState> emit,
  ) {
    final prefs = getIt.get<SharedPreferences>();
    final token = prefs.getString('token');
    final id = prefs.getString('id');
    final firstName = prefs.getString('firstName');
    final lastName = prefs.getString('lastName');
    final email = prefs.getString('email');
    final phone = prefs.getString('phone');
    final dob = prefs.getString('dob');
    final gender = prefs.getString('gender');
    final city = prefs.getString('city');
    final photo = prefs.getString('photo');

    UserModel user = const UserModel(
      id: '-',
      firstName: '-',
      lastName: '-',
      email: '-',
      phone: '-',
      dob: '-',
      gender: '-',
      city: '-',
      photo: '-',
    );

    if (token != null &&
        id != null &&
        firstName != null &&
        lastName != null &&
        email != null &&
        phone != null &&
        dob != null &&
        gender != null &&
        city != null &&
        photo != null) {
      user = UserModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        dob: dob,
        gender: gender,
        city: city,
        photo: photo,
      );
    }

    emit(ProfileDone(user));
  }
}
