import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../injection_container.dart';
import '../../../../data/models/login_request.dart';
import '../../../../data/models/register_request.dart';
import '../../../../data/models/user.dart';
import '../../../../domain/usecases/login.dart';
import '../../../../domain/usecases/register.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(this._loginUseCase, this._registerUseCase)
      : super(const PrepareUser()) {
    on<Register>(onRegister);
    on<SignIn>(onSignIn);
    on<SignOut>(onSignOut);
    on<CheckSignInStatus>(onCheckSignInStatus);
  }

  void _setSession(String token, UserModel user) {
    final prefs = getIt.get<SharedPreferences>();

    prefs.setString('token', token);
    prefs.setString('id', user.id!);
    prefs.setString('email', user.email!);
    prefs.setString('name', user.name!);
    prefs.setString('phone', user.phone!);
    prefs.setString('photo', user.photo!);
  }

  void onRegister(Register event, Emitter<AuthState> emit) async {
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
        emit(const UserNotFound());
      }
    }

    if (dataState is DataFailed) {
      emit(AuthError(dataState.error!));
    }
  }

  void onSignIn(SignIn event, Emitter<AuthState> emit) async {
    if (state is UserSignedOut) {
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
          emit(const UserNotFound());
        }
      }

      if (dataState is DataFailed) {
        emit(AuthError(dataState.error!));
      }
    }
  }

  void onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final prefs = getIt.get<SharedPreferences>();
    prefs.remove('token');
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('photo');

    emit(const UserSignedOut());
  }

  void onCheckSignInStatus(
    CheckSignInStatus event,
    Emitter<AuthState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 5), () {
      final pref = getIt.get<SharedPreferences>();
      final token = pref.getString('token');
      final id = pref.getString('id');
      final email = pref.getString('email');
      final name = pref.getString('name');
      final phone = pref.getString('phone');
      final photo = pref.getString('photo');

      if (token != null &&
          id != null &&
          email != null &&
          name != null &&
          phone != null &&
          photo != null) {
        final user = UserModel(
          id: id,
          email: email,
          name: name,
          phone: phone,
          photo: photo,
        );
        emit(UserSignedIn(user));
      } else {
        emit(const UserSignedOut());
      }
    });
  }
}
