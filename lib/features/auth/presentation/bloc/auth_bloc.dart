import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/message_response.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/login_request.dart';
import '../../domain/entities/register_request.dart';
import '../../data/models/user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(this._loginUseCase, this._registerUseCase)
      : super(const AuthInitialState()) {
    on<Register>(onRegister);
    on<SignIn>(onSignIn);
    on<SignOut>(onSignOut);
    on<CheckSignInStatus>(onCheckSignInStatus);
  }

  void _setSession(String token, UserModel user) {
    final prefs = getIt.get<SharedPreferences>();

    prefs.setString('token', token);
    prefs.setString('id', user.id!);
    prefs.setString('firstName', user.firstName!);
    prefs.setString('lastName', user.lastName!);
    prefs.setString('email', user.email!);
    prefs.setString('phone', user.phone!);
    prefs.setString('dob', user.dob!);
    prefs.setString('gender', user.gender!);
    prefs.setString('city', user.city!);
    prefs.setString('photo', user.photo!);
  }

  void onRegister(
    Register event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final registerRequest = RegisterRequest(
      firstName: event.firstName,
      lastName: event.lastName,
      dob: event.dob,
      city: event.city,
      gender: event.gender,
      email: event.email,
      phone: event.phone,
      password: event.password,
      confirmPassword: event.confirmPassword,
    );

    final dataState = await _registerUseCase(params: registerRequest);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final token = dataState.data!.token;
        final user = UserModel.fromJson(dataState.data!.data);

        _setSession(token!, user);

        emit(UserSignedIn(user));
      } else {
        final messageResponse = MessageResponse(
          status: false,
          title: 'Oppss...',
          message: dataState.data!.message!,
        );

        emit(AuthMessage(messageResponse));
      }
    }

    if (dataState is DataFailed) {
      emit(AuthError(dataState.error!));
    }
  }

  void onSignIn(
    SignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final loginRequest = LoginRequest(
      email: event.email,
      password: event.password,
    );

    final dataState = await _loginUseCase(params: loginRequest);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final token = dataState.data!.token;
        final user = UserModel.fromJson(dataState.data!.data);

        _setSession(token!, user);

        emit(UserSignedIn(user));
      } else {
        final messageResponse = MessageResponse(
          status: false,
          title: 'Oppss...',
          message: dataState.data!.message!,
        );

        emit(AuthMessage(messageResponse));
      }
    }

    if (dataState is DataFailed) {
      emit(AuthError(dataState.error!));
    }
  }

  void onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final prefs = getIt.get<SharedPreferences>();
    prefs.remove('token');
    prefs.remove('id');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('dob');
    prefs.remove('gender');
    prefs.remove('city');
    prefs.remove('photo');

    emit(const UserSignedOut());
  }

  void onCheckSignInStatus(
    CheckSignInStatus event,
    Emitter<AuthState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 5), () {
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
        final user = UserModel(
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
        emit(UserSignedIn(user));
      } else {
        emit(const UserSignedOut());
      }
    });
  }
}
