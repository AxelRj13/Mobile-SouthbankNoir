import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/message_response.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/data/models/user.dart';
import '../../../domain/entities/profile_request.dart';
import '../../../domain/usecases/update_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  ProfileBloc(this._updateProfileUseCase) : super(const ProfileInitial()) {
    on<UpdateProfile>(onUpdateProfile);
    on<CheckProfile>(onCheckProfile);
  }

  void onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    final prefs = getIt.get<SharedPreferences>();

    final profileRequest = ProfileRequest(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      phone: event.phone,
      dob: event.dob,
      city: event.city,
      file: event.image,
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

        prefs.setString('token', token!);
        prefs.setString('id', user.id!);
        prefs.setString('firstName', user.firstName!);
        prefs.setString('lastName', user.lastName!);
        prefs.setString('email', user.email!);
        prefs.setString('phone', user.phone!);
        prefs.setString('dob', user.dob!);
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

      emit(ProfileUpdateMessage(message: messageResponse));
    }

    if (dataState is DataFailed) {
      emit(ProfileUpdateError(dataState.error!));
    }
  }

  void onCheckProfile(
    CheckProfile event,
    Emitter<ProfileState> emit,
  ) {
    emit(const ProfileLoading());

    final prefs = getIt.get<SharedPreferences>();
    final token = prefs.getString('token');
    final id = prefs.getString('id');
    final firstName = prefs.getString('firstName');
    final lastName = prefs.getString('lastName');
    final email = prefs.getString('email');
    final phone = prefs.getString('phone');
    final dob = prefs.getString('dob');
    final city = prefs.getString('city');
    final photo = prefs.getString('photo');

    UserModel user = const UserModel(
      id: '-',
      firstName: '-',
      lastName: '-',
      email: '-',
      phone: '-',
      dob: '-',
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
        city != null &&
        photo != null) {
      user = UserModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        dob: dob,
        city: city,
        photo: photo,
      );
    }

    emit(ProfileDone(user: user));
  }
}
