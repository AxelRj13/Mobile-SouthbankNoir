import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/utils/validator_extension.dart';
import '../bloc/auth/remote/auth_bloc.dart';
import '../bloc/auth/remote/auth_event.dart';
import '../bloc/auth/remote/auth_state.dart';
import 'google_button.dart';

class FormLogin extends StatefulWidget {
  final Function() onFormSwitchTap;

  const FormLogin({super.key, required this.onFormSwitchTap});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool? passwordObscure;

  @override
  void initState() {
    super.initState();
    passwordObscure = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              SBTextFormField(
                controller: _emailController,
                hintText: 'Email / Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the email / phone number field';
                  }
                  if (!value.isEmail && !value.isPhone) {
                    return 'Please enter a valid email / phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              SBTextFormField(
                controller: _passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the password field';
                  }
                  return null;
                },
                isPassword: passwordObscure!,
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordObscure! ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordObscure = !passwordObscure!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              SBButton(
                color: Colors.black,
                onPressed: (state is AuthLoading)
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());

                          BlocProvider.of<AuthBloc>(context).add(
                            SignIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
                child: (state is AuthLoading)
                    ? const Center(
                        child: SBLoading(),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(fontSize: 16.0),
                      ),
              ),
              const SizedBox(height: 30.0),
              const Text('OR'),
              const SizedBox(height: 30.0),
              const GoogleButton(),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member?'),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: widget.onFormSwitchTap,
                    child: Text(
                      'Register now',
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
