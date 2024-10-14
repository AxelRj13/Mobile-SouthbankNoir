import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/message_response.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/login_request.dart';
import '../../domain/entities/register_request.dart';
import '../../data/models/user.dart';
import '../../domain/usecases/check_email.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckEmailUseCase _checkEmailUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(
    this._checkEmailUseCase,
    this._loginUseCase,
    this._registerUseCase,
  ) : super(const AuthInitialState()) {
    on<CheckSignInStatus>(onCheckSignInStatus);
    on<LoginGoogle>(onLoginGoogle);
    on<Login>(onLogin);
    on<Logout>(onLogout);
    on<Register>(onRegister);
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
    prefs.setString('city', user.city!);
    prefs.setString('photo', user.photo!);
  }

  void _result(
    DataState dataState,
    Emitter<AuthState> emit,
  ) {
    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final token = dataState.data!.token;
        final user = UserModel.fromJson(dataState.data!.data);

        _setSession(token!, user);

        emit(
          AuthUserLogin(user: user),
        );
      } else {
        final messageResponse = MessageResponse(
          status: false,
          title: 'Oppss...',
          message: dataState.data!.message!,
        );

        emit(
          AuthMessage(message: messageResponse),
        );
      }
    }

    if (dataState is DataFailed) {
      emit(AuthError(dataState.error!));
    }
  }

  Future<void> _login(
    Emitter<AuthState> emit, {
    String? email,
    String? password,
    bool? isViaGoogle,
  }) async {
    final loginRequest = LoginRequest(
      email: email!,
      password: password,
      isViaGoogle: isViaGoogle!,
    );

    final dataState = await _loginUseCase(params: loginRequest);

    _result(dataState, emit);
  }

  Future<void> _register(
    Emitter<AuthState> emit, {
    String? firstName,
    String? lastName,
    String? dob,
    String? city,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
  }) async {
    final registerRequest = RegisterRequest(
      firstName: firstName!,
      lastName: lastName,
      dob: dob!,
      city: city!,
      email: email,
      phone: phone!,
      password: password!,
      confirmPassword: confirmPassword!,
    );

    final dataState = await _registerUseCase(params: registerRequest);

    _result(dataState, emit);
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
      final city = prefs.getString('city');
      final photo = prefs.getString('photo');

      if (token != null &&
          id != null &&
          firstName != null &&
          lastName != null &&
          email != null &&
          phone != null &&
          dob != null &&
          city != null &&
          photo != null) {
        final user = UserModel(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          dob: dob,
          city: city,
          photo: photo,
        );
        emit(
          AuthUserLogin(user: user),
        );
      } else {
        emit(const AuthUserLogout());
      }
    });
  }

  void onLoginGoogle(
    LoginGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthGoogleLoading());

    final dataState = await _checkEmailUseCase(params: event.email);

    if (dataState is DataSuccess) {
      final status = dataState.data!.status;

      if (status == 1) {
        final alreadyRegistered = dataState.data!.data['alreadyRegistered'] as bool;

        if (!alreadyRegistered) {
          await _register(
            emit,
            firstName: event.name ?? 'Southbank Member',
            dob: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            city: 'BANDUNG',
            email: event.email,
            password: event.id,
            confirmPassword: event.id,
          );
        } else {
          await _login(
            emit,
            email: event.email,
            isViaGoogle: true,
          );
        }
      } else {
        final messageResponse = MessageResponse(
          status: false,
          title: 'Oppss...',
          message: dataState.data!.message!,
        );

        emit(
          AuthMessage(message: messageResponse),
        );
      }
    }

    if (dataState is DataFailed) {
      emit(AuthError(dataState.error!));
    }
  }

  void onLogin(
    Login event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    await _login(
      emit,
      email: event.email,
      password: event.password,
      isViaGoogle: false,
    );
  }

  void onLogout(
    Logout event,
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
    prefs.remove('city');
    prefs.remove('photo');

    emit(const AuthUserLogout());
  }

  void onRegister(
    Register event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    await _register(
      emit,
      firstName: event.firstName,
      lastName: event.lastName,
      dob: event.dob,
      city: event.city,
      email: event.email,
      phone: event.phone,
      password: event.password,
      confirmPassword: event.confirmPassword,
    );
  }
}
