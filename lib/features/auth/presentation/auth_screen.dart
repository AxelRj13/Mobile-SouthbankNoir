import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/dialog.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';
import 'widgets/auth_container.dart';
import 'widgets/form_login.dart';
import 'widgets/form_register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginForm = true;

  void _switchForm() {
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthMessage) {
          await basicDialog(context, state.message!.title, state.message!.message);
        }
      },
      child: SafeArea(
        child: AuthContainer(
          children: [
            const SizedBox(height: 30.0),
            _isLoginForm
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(180.0),
                    child: Image.asset('assets/img/logo.png', width: 280.0),
                  )
                : const Text(
                    'Register Member',
                    style: TextStyle(fontSize: 24.0),
                  ),
            _isLoginForm ? const SizedBox(height: 50.0) : const SizedBox(height: 20.0),
            _isLoginForm ? FormLogin(onFormSwitchTap: () => _switchForm()) : FormRegister(onFormSwitchTap: () => _switchForm()),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
